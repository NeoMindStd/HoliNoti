package com.neomind.holinoti_server.facility;

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
@RequestMapping(value = PathString.FACILITIES, consumes = MediaType.APPLICATION_JSON_VALUE, produces = MediaType.APPLICATION_JSON_VALUE)
public class FacilityController {
    FacilityRepository facilityRepository;
    FacilityService facilityService;
    UserService userService;

    @GetMapping
    public List<Facility> getAllFacilities() {
        return facilityRepository.findAll();
    }

    @RequestMapping(path = PathString.CODE_PATH + "{facilityCode}", method = RequestMethod.GET)
    public Facility getFacility(@PathVariable("facilityCode") int code) {
        return facilityRepository.findById(code).get();
    }

    @RequestMapping(path = PathString.PHONE_NUMBER_PATH + "{phoneNumber}", method = RequestMethod.GET)
    public Facility getFacilityByPhoneNumber(@PathVariable("phoneNumber") String phoneNumber) {
        return facilityRepository.findByPhoneNumber(phoneNumber);
    }

    @PostMapping
    public ResponseEntity addFacility(@RequestBody Facility facility) {
        Facility newFacility = facilityRepository.save(facility);
        try {
            facilityService.linkSupervisorAndFacility(newFacility.getCode());
            URI createdURI = linkTo(FacilityController.class).slash(newFacility.getCode()).toUri();
            return ResponseEntity.created(createdURI).body(newFacility);
        } catch (Exception e) {
            try {
                deleteFacility(newFacility.getCode());
            } catch (Exception ex) {
                ex.printStackTrace();
            }
            return new ResponseEntity<String>(e.getMessage(), HttpStatus.BAD_REQUEST);
        }
    }

    @RequestMapping(path = PathString.X_PATH + "{x}" + PathString.Y_PATH + "{y}" +
            PathString.DISTANCE_PATH + "{distanceM}", method = RequestMethod.GET)
    public List<Facility> getFacilitiesByCoordinates(@PathVariable("x") double x, @PathVariable("y") double y,
                                                     @PathVariable("distanceM") int side) {
        return facilityService.queryByDistance(x, y, side);
    }

    @RequestMapping(path = PathString.X_PATH + "{x}" + PathString.Y_PATH + "{y}" +
            PathString.DISTANCE_PATH + "{distanceM}" + PathString.NAME_PATH + "{name}", method = RequestMethod.GET)
    public List<Facility> getFacilitiesByCoordinatesAndName(@PathVariable("x") double x, @PathVariable("y") double y,
                                                            @PathVariable("distanceM") int side, @PathVariable("name") String nam) {
        return facilityService.queryByName(x, y, side, nam);
    }

    @RequestMapping(path = PathString.NAME_PATH + "{name}", method = RequestMethod.GET)
    public List<Facility> getFacilitiesByName(@PathVariable("name") String name) {
        return facilityRepository.findAllByName(name);
    }

    @RequestMapping(path = PathString.CODE_PATH + "{facilityCode}", method = RequestMethod.PUT)
    @ResponseStatus(HttpStatus.OK)
    public ResponseEntity updateFacility(@RequestBody Facility facility,
                                         @PathVariable("facilityCode") int code) throws Exception {
        if (!userService.isAccessible(code)) throw new Exception("Prohibited: Low Grade Role");

        Facility target = facilityRepository.findById(code).get();

        target.setName(facility.getName());
        target.setAddress(facility.getAddress());
        target.setSiteUrl(facility.getSiteUrl());
        target.setComment(facility.getComment());
        target.setCoordinates(facility.getCoordinates());

        facilityRepository.save(target);

        return ResponseEntity.ok().body(target);
    }

    @RequestMapping(path = PathString.CODE_PATH + "{facilityCode}", method = RequestMethod.DELETE)
    public void deleteFacility(@PathVariable("facilityCode") int code) throws Exception {
        if (!userService.isAccessible(code)) throw new Exception("Prohibited: Low Grade Role");
        facilityService.deleteAllRowInRelationAF(code);
        facilityRepository.deleteById(code);
    }
}