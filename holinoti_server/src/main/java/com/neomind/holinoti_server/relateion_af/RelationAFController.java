package com.neomind.holinoti_server.relateion_af;

import com.neomind.holinoti_server.facility.FacilityRepository;
import com.neomind.holinoti_server.facility.FacilityService;
import com.neomind.holinoti_server.user.UserService;
import lombok.AllArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.net.URI;
import java.util.List;

import static com.neomind.holinoti_server.constants.Strings.PathString;
import static org.springframework.hateoas.server.mvc.WebMvcLinkBuilder.linkTo;

@RestController
@AllArgsConstructor
@RequestMapping(value = PathString.RELATION_AFS, consumes = MediaType.APPLICATION_JSON_VALUE, produces = MediaType.APPLICATION_JSON_VALUE)
public class RelationAFController {
    RelationAFRepository relationAFRepository;
    FacilityRepository facilityRepository;
    FacilityService facilityService;
    UserService userService;
    RelationAFService relationAFService;

    @GetMapping
    public List<RelationAF> getAllRelationAFs() {
        return relationAFRepository.findAll();
    }

    @RequestMapping(path = PathString.ID_PATH + "{relationAFId}", method = RequestMethod.GET)
    public RelationAF getRelationAFById(@PathVariable("relationAFId") int id) {
        return relationAFRepository.findById(id).get();
    }

    @RequestMapping(path = PathString.USER_ID_PATH + "{userId}", method = RequestMethod.GET)
    public List<RelationAF> getRelationAFsByUserId(@PathVariable("userId") int userId) {
        return relationAFRepository.findByUserId(userId);
    }

    @RequestMapping(path = PathString.FACILITY_CODE_PATH + "{facilityCode}", method = RequestMethod.GET)
    public List<RelationAF> getRelationAFsByFacilityCode(@PathVariable("facilityCode") int facilityCode) {
        return relationAFRepository.findByFacilityCode(facilityCode);
    }

    @PostMapping
    public ResponseEntity addRelationAF(@RequestBody RelationAF relationAF) throws Exception {
        if (!(relationAF.getRole().ordinal() == Role.customer.ordinal() ||
                !userService.isAccessible(relationAF.getFacilityCode())))
            throw new Exception("Prohibited: Low Grade Role");
        RelationAF newRelationAF = relationAFRepository.save(relationAF);
        URI createdURI = linkTo(RelationAFController.class).slash(newRelationAF.getId()).toUri();
        return ResponseEntity.created(createdURI).body(newRelationAF);
    }

    @RequestMapping(path = PathString.ID_PATH + "{relationAFId}", method = RequestMethod.PUT)
    @ResponseStatus(HttpStatus.OK)
    public void updateRelationAF(@RequestBody RelationAF relationAF,
                                 @PathVariable("relationAFId") int id) throws Exception {
        if (!userService.isAccessible(relationAF.getFacilityCode())) throw new Exception("Prohibited: Low Grade Role");
        RelationAF target = relationAFRepository.findById(id).get();

        target.setUserId(relationAF.getUserId());
        target.setFacilityCode(relationAF.getFacilityCode());
        if (target.getRole() == Role.supervisor && relationAF.getRole() != Role.supervisor) {
            relationAFService.deleteAllFacilityWithoutSupervisor(target.getFacilityCode());
        }

        target.setRole(relationAF.getRole());

        relationAFRepository.save(target);
    }

    @RequestMapping(path = PathString.ID_PATH + "{relationAFId}", method = RequestMethod.DELETE)
    public void deleteRelationAF(@PathVariable("relationAFId") int id) throws Exception {
        RelationAF target = relationAFRepository.findById(id).get();

        if (!userService.isAccessible(target.getFacilityCode())) throw new Exception("Prohibited: Low Grade Role");
        relationAFRepository.deleteById(id);

        if (target.getRole() == Role.supervisor) {
            relationAFService.deleteAllFacilityWithoutSupervisor(target.getFacilityCode());
        }
    }
}