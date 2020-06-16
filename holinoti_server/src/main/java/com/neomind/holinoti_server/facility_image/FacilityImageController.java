package com.neomind.holinoti_server.facility_image;

import com.neomind.holinoti_server.user.UserService;
import lombok.AllArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.net.URI;
import java.util.List;

import static com.neomind.holinoti_server.constants.Strings.PathString;
import static org.springframework.hateoas.server.mvc.WebMvcLinkBuilder.linkTo;

@RestController
@AllArgsConstructor
@RequestMapping(value = PathString.FACILITIES_IMAGES_FULL_PATH, consumes = MediaType.APPLICATION_JSON_VALUE, produces = MediaType.APPLICATION_JSON_VALUE)
public class FacilityImageController {
    FacilityImageRepository facilityImageRepository;
    FacilityImageService facilityImageService;
    UserService userService;

    @GetMapping
    public List<FacilityImage> getAllFacilityImages() {
        System.out.println("getAllFacilityImages:: START");
        return facilityImageRepository.findAll();
    }

    @RequestMapping(path = PathString.ID_PATH + "{facilityImageId}", method = RequestMethod.GET)
    public FacilityImage getFacilityImage(@PathVariable("facilityImageId") int id) {
        return facilityImageRepository.findById(id).get();
    }

    @RequestMapping(path = PathString.FACILITY_CODE_PATH + "{facilityCode}", method = RequestMethod.GET)
    public List<FacilityImage> getFacilityImagesByFacilityCode(@PathVariable("facilityCode") int facilityCode) {
        return facilityImageRepository.findFacilityImagesByFacilityCode(facilityCode);
    }

    @RequestMapping(method = RequestMethod.POST, consumes = MediaType.MULTIPART_FORM_DATA_VALUE)
    public ResponseEntity<?> addFacilityImage(@RequestParam("file") MultipartFile uploadFile,
                                              @RequestParam("facility_code") int facilityCode) throws Exception {
        if (!userService.isAccessible(facilityCode))
            throw new Exception("Prohibited: Low Grade Role");
        FacilityImage facilityImage = new FacilityImage();

        try {
            facilityImageService.upload(facilityImage, uploadFile, facilityCode);
        } catch (Exception e) {
            e.printStackTrace();
            return new ResponseEntity<>(e.getMessage(), HttpStatus.BAD_REQUEST);
        }

        URI createdURI = linkTo(FacilityImageController.class).slash(facilityImage.getId()).toUri();
        return ResponseEntity.created(createdURI).body(facilityImage);
    }

    @RequestMapping(path = PathString.ID_PATH + "{facilityImageId}", method = RequestMethod.PUT,
            consumes = MediaType.MULTIPART_FORM_DATA_VALUE)
    @ResponseStatus(HttpStatus.OK)
    public void updateFacilityImage(@RequestBody FacilityImage facilityImage,
                                    @PathVariable("facilityImageId") int id) throws Exception {
        if (!userService.isAccessible(facilityImage.getFacilityCode()))
            throw new Exception("Prohibited: Low Grade Role");
        FacilityImage target = facilityImageRepository.findById(id).get();

        target.setFileName(facilityImage.getFileName());
        target.setFacilityCode(facilityImage.getFacilityCode());

        facilityImageRepository.save(target);
    }

    @RequestMapping(path = PathString.ID_PATH + "{facilityImageId}", method = RequestMethod.DELETE)
    public void deleteFacilityImage(@PathVariable("facilityImageId") int id) throws Exception {
        FacilityImage facilityImage = facilityImageRepository.findById(id).get();
        if (!userService.isAccessible(facilityImage.getFacilityCode()))
            throw new Exception("Prohibited: Low Grade Role");
        String path = facilityImageRepository.findById(id).get().getFileName();
        File delFile = new File(path);
        if (delFile.exists())
            delFile.delete();
        facilityImageRepository.deleteById(id);
    }
}

