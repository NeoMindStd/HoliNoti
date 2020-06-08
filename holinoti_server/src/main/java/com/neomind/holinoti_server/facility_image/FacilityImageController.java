package com.neomind.holinoti_server.facility_image;

import com.neomind.holinoti_server.facility.FacilityService;
import com.neomind.holinoti_server.user.UserService;
import lombok.AllArgsConstructor;
import org.springframework.boot.web.servlet.MultipartConfigFactory;
import org.springframework.context.annotation.Bean;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;

import javax.servlet.MultipartConfigElement;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
import java.io.*;
import java.net.URI;
import java.net.URL;
import java.util.List;

import static com.neomind.holinoti_server.constants.Strings.PathString;
import static org.springframework.hateoas.server.mvc.WebMvcLinkBuilder.linkTo;

@RestController
@AllArgsConstructor
@RequestMapping(value = PathString.FACILITIES_IMAGES_FULL_PATH)
public class FacilityImageController {
    FacilityImageRepository facilityImageRepository;
    FacilityImageService facilityImageService;
    UserService userService;

    @GetMapping(consumes = MediaType.APPLICATION_JSON_VALUE, produces = MediaType.APPLICATION_JSON_VALUE)
    public List<FacilityImage> getAllFacilityImages() {
        return facilityImageRepository.findAll();
    }

    @RequestMapping(path = PathString.ID_PATH + "{facilityImageId}", method = RequestMethod.GET,
            consumes = MediaType.APPLICATION_JSON_VALUE, produces = MediaType.APPLICATION_JSON_VALUE)
    public FacilityImage getFacilityImage(@PathVariable("facilityImageId") int id) {
        return facilityImageRepository.findById(id).get();
    }

    @RequestMapping(path = PathString.FACILITY_CODE_PATH + "{facilityCode}", method = RequestMethod.GET,
            consumes = MediaType.APPLICATION_JSON_VALUE, produces = MediaType.APPLICATION_JSON_VALUE)
    public List<FacilityImage> getManagerByFacilityCode(@PathVariable("facilityCode") int facilityCode) {
        return facilityImageRepository.findFacilityImagesByFacilityCode(facilityCode);
    }

    //TODO 리눅스 톰캣 서버에서 동작 버그 고치기
    @PostMapping(consumes = "multipart/form-data", produces = MediaType.APPLICATION_JSON_VALUE)
    public ResponseEntity addFacilityImage(@RequestParam("file") MultipartFile uploadFile,
                                           @RequestParam("facility_code") int facilityCode,
                                           HttpServletRequest request) throws Exception {
        if (!userService.isAccessible(facilityCode))
            throw new Exception("Prohibited: Low Grade Role");

        System.out.println("addFacilityImage::START");
        String url = facilityImageService.upload(uploadFile, facilityCode);


//        String path = PathString.FACILITIES_IMAGES_FULL_PATH + "/" + facilityCode + "/";
//        String fileName = "";
//
//        OutputStream out = null;
//        PrintWriter printWriter = null;
//
//        try {
//            fileName = uploadFile.getOriginalFilename();
//            byte[] bytes = uploadFile.getBytes();
//
//            System.out.println("UtilFile fileUpload fileName : " + fileName);
//            System.out.println("UtilFile fileUpload uploadPath : " + path);
//            fileName = System.currentTimeMillis() + "_" + fileName;
//
//            File file = new File(path + fileName);
//            uploadFile.transferTo(file);
//        }catch (Exception e) {
//            e.printStackTrace();
//            return new ResponseEntity<String>(e.getMessage(), HttpStatus.BAD_REQUEST);
//        }

        FacilityImage newFacilityImage = new FacilityImage();
        newFacilityImage.setPath(url);
        newFacilityImage.setFacilityCode(facilityCode);

        facilityImageRepository.save(newFacilityImage);
        URI createdURI = linkTo(FacilityImageController.class).slash(newFacilityImage.getFacilityCode()).toUri();
        return ResponseEntity.created(createdURI).body(newFacilityImage);
    }

    @RequestMapping(path = PathString.ID_PATH + "{facilityImageId}", method = RequestMethod.PUT,
            consumes = MediaType.APPLICATION_JSON_VALUE, produces = MediaType.APPLICATION_JSON_VALUE)
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

    @RequestMapping(path = PathString.ID_PATH + "{facilityImageId}", method = RequestMethod.DELETE,
            consumes = MediaType.APPLICATION_JSON_VALUE, produces = MediaType.APPLICATION_JSON_VALUE)
    public void deleteFacilityImage(@PathVariable("facilityImageId") int id) throws Exception {
        FacilityImage facilityImage = facilityImageRepository.findById(id).get();
        if (!userService.isAccessible(facilityImage.getFacilityCode()))
            throw new Exception("Prohibited: Low Grade Role");
        String path = facilityImageRepository.findById(id).get().getPath();
        File delFile = new File(path);
        if(delFile.exists())
            delFile.delete();
        facilityImageRepository.deleteById(id);
    }
}

