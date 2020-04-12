package com.neomind.holinoti_server.relateion_af;

import lombok.AllArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.net.URI;
import java.util.List;

import static org.springframework.hateoas.server.mvc.WebMvcLinkBuilder.linkTo;

@RestController
@AllArgsConstructor
@RequestMapping(value = "/relation_afs", consumes = MediaType.APPLICATION_JSON_VALUE, produces = MediaType.APPLICATION_JSON_VALUE)
public class RelationAFController {
    RelationAFRepository relationAFRepository;

    @GetMapping
    public List<RelationAF> getAllRelationAFs() {
        return relationAFRepository.findAll();
    }

    @RequestMapping(path = "/id={relationAFId}", method = RequestMethod.GET)
    public RelationAF getRelationAFById(@PathVariable("relationAFId") int id) {
        return relationAFRepository.findById(id).get();
    }

    @RequestMapping(path = "/user_id={userId}", method = RequestMethod.GET)
    public List<RelationAF> getRelationAFsByUserId(@PathVariable("userId") int userId) {
        return relationAFRepository.findByUserId(userId);
    }

    @RequestMapping(path = "/facility_code={facilityCode}", method = RequestMethod.GET)
    public List<RelationAF> getRelationAFsByFacilityCode(@PathVariable("facilityCode") int facilityCode) {
        return relationAFRepository.findByFacilityCode(facilityCode);
    }

    @PostMapping
    public ResponseEntity addRelationAF(@RequestBody RelationAF relationAF) {
        RelationAF newRelationAF = relationAFRepository.save(relationAF);
        URI createdURI = linkTo(RelationAFController.class).slash(newRelationAF.getId()).toUri();
        return ResponseEntity.created(createdURI).body(newRelationAF);
    }

    @RequestMapping(path = "/id={relationAFId}", method = RequestMethod.PUT)
    @ResponseStatus(HttpStatus.OK)
    public void updateRelationAF(@RequestBody RelationAF relationAF,
                                 @PathVariable("relationAFId") int id) {
        RelationAF target = relationAFRepository.findById(id).get();

        target.setUserId(relationAF.getUserId());
        target.setFacilityCode(relationAF.getFacilityCode());
        target.setRole(relationAF.getRole());

        relationAFRepository.save(target);
    }

    @RequestMapping(path = "/id={relationAFId}", method = RequestMethod.DELETE)
    public void deleteRelationAF(@PathVariable("relationAFId") int id) {
        relationAFRepository.deleteById(id);
    }
}