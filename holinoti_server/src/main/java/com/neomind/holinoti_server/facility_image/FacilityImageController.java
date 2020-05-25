package com.neomind.holinoti_server.facility_image;

import com.neomind.holinoti_server.user.UserService;
import lombok.AllArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.net.URI;
import java.util.List;

import static org.springframework.hateoas.server.mvc.WebMvcLinkBuilder.linkTo;
import static com.neomind.holinoti_server.constants.Strings.PathString;

@RestController
@AllArgsConstructor
@RequestMapping(value = PathString.FACILITIES_IMAGES_FULL_PATH, consumes = MediaType.APPLICATION_JSON_VALUE, produces = MediaType.APPLICATION_JSON_VALUE)
public class FacilityImageController {
    FacilityImageRepository facilityImageRepository;
    UserService userService;

    @GetMapping
    public List<FacilityImage> getAllFacilityImages() {
        return facilityImageRepository.findAll();
    }

    @RequestMapping(path = PathString.ID_PATH + "{facilityImageId}", method = RequestMethod.GET)
    public FacilityImage getFacilityImage(@PathVariable("facilityImageId") int id) {
        return facilityImageRepository.findById(id).get();
    }

    @RequestMapping(path = PathString.FACILITY_CODE_PATH + "{facilityCode}", method = RequestMethod.GET)
    public List<FacilityImage> getManagerByFacilityCode(@PathVariable("facilityCode") int facilityCode) {
        return facilityImageRepository.findFacilityImagesByFacilityCode(facilityCode);
    }

    @PostMapping
    public ResponseEntity addFacilityImage(@RequestBody FacilityImage facilityImage) throws Exception {
        if (!userService.isAccessible(facilityImage.getFacilityCode()))
            throw new Exception("Prohibited: Low Grade Role");
        FacilityImage newFacilityImage = facilityImageRepository.save(facilityImage);
        URI createdURI = linkTo(FacilityImageController.class).slash(newFacilityImage.getFacilityCode()).toUri();
        return ResponseEntity.created(createdURI).body(newFacilityImage);
    }

    @RequestMapping(path = PathString.ID_PATH + "{facilityImageId}", method = RequestMethod.PUT)
    @ResponseStatus(HttpStatus.OK)
    public void updateFacilityImage(@RequestBody FacilityImage facilityImage,
                                    @PathVariable("facilityImageId") int id) throws Exception {
        if (!userService.isAccessible(facilityImage.getFacilityCode()))
            throw new Exception("Prohibited: Low Grade Role");
        FacilityImage target = facilityImageRepository.findById(id).get();

        target.setPath(facilityImage.getPath());
        target.setFacilityCode(facilityImage.getFacilityCode());

        facilityImageRepository.save(target);
    }

    @RequestMapping(path = PathString.ID_PATH + "{facilityImageId}", method = RequestMethod.DELETE)
    public void deleteFacilityImage(@PathVariable("facilityImageId") int id) throws Exception {
        if (!userService.isAccessible(facilityImageRepository.findById(id).get().getFacilityCode()))
            throw new Exception("Prohibited: Low Grade Role");
        facilityImageRepository.deleteById(id);
    }
}