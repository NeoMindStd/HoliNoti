package com.neomind.holinoti_server.facility_image;

import com.neomind.holinoti_server.constants.Strings;
import lombok.AllArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;

@Service
@AllArgsConstructor
public class FacilityImageService {
    FacilityImageRepository facilityImageRepository;
    public void upload(FacilityImage newFacilityImage, MultipartFile uploadFile, int facilityCode) throws Exception{
        //windows 용
//        String path = "C:"+ Strings.PathString.FACILITY_IMAGE_FILE_PATH + "/" + facilityCode;
        //Linux 용
        String path = Strings.PathString.FACILITY_IMAGE_FILE_PATH + "/" + facilityCode;
        String fileName = "";

        fileName = uploadFile.getOriginalFilename();
        System.out.println(fileName+"구와아아악");
        if(fileName == null || fileName.isEmpty())
            throw new Exception("empty file");
        try {
            newFacilityImage.setPath("");
            newFacilityImage.setFacilityCode(facilityCode);
            facilityImageRepository.save(newFacilityImage);
            fileName = System.currentTimeMillis() + "_" + newFacilityImage.getId()+ "_" + fileName;
            newFacilityImage.setPath(path + "/" + fileName);
            facilityImageRepository.save(newFacilityImage);

            File directory = new File(path);
            if (!directory.exists()) {
                if (directory.mkdir()) {
                    System.out.println("Directory is created!");
                } else {
                    System.out.println("Failed to create directory!");
                }
            }
            byte[] bytes = uploadFile.getBytes();

            System.out.println("UtilFile fileUpload fileName : " + fileName);
            System.out.println("UtilFile fileUpload uploadPath : " + path);

            File file = new File(path + "/" + fileName);
            uploadFile.transferTo(file);
        }catch (Exception e) {
            facilityImageRepository.deleteById(newFacilityImage.getId());
            throw e;
        }
    }
}
