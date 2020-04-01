package com.neomind.holinoti_server.facility_image;

import com.neomind.holinoti_server.manager.Manager;
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
@RequestMapping(value = "/facilities/facility_images", consumes = MediaType.APPLICATION_JSON_VALUE, produces = MediaType.APPLICATION_JSON_VALUE)
public class FacilityImageController {
    FacilityImageRepository facilityImageRepository;

    @GetMapping
    public List<FacilityImage> getAllFacilityImages() {
        return facilityImageRepository.findAll();
    }

    @RequestMapping(path = "/id={facilityImageId}", method = RequestMethod.GET)
    public FacilityImage getFacilityImage(@PathVariable("facilityImageId") int id) {
        return facilityImageRepository.findById(id).get();
    }

    @RequestMapping(path = "/facility_code={facilityCode}", method = RequestMethod.GET)
    public List<FacilityImage> getManagerByFacilityCode(@PathVariable("facilityCode") int facilityCode) {
        return facilityImageRepository.findFacilityImagesByFacilityCode(facilityCode);
    }

    @PostMapping
    public ResponseEntity addFacilityImage(@RequestBody FacilityImage facilityImage) {
        System.out.println(facilityImage);
        FacilityImage newFacilityImage = facilityImageRepository.save(facilityImage);
        URI createdURI = linkTo(FacilityImageController.class).slash(newFacilityImage.getFacilityCode()).toUri();
        return ResponseEntity.created(createdURI).body(newFacilityImage);
    }

    @RequestMapping(path = "/id={facilityImageId}", method = RequestMethod.PUT)
    @ResponseStatus(HttpStatus.OK)
    public void updateFacilityImage(@RequestBody FacilityImage facilityImage,
                                  @PathVariable("facilityImageId") int id) {
        FacilityImage target = facilityImageRepository.findById(id).get();

        target.setFacilityCode(facilityImage.getFacilityCode());

        facilityImageRepository.save(target);
    }

    @RequestMapping(path = "/id={facilityImageId}", method = RequestMethod.DELETE)
    public void deleteFacilityImage(@PathVariable("facilityImageId") int id) {
        facilityImageRepository.deleteById(id);
    }
}