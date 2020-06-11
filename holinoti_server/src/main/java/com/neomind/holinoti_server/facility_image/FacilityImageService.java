package com.neomind.holinoti_server.facility_image;

import com.neomind.holinoti_server.constants.Strings;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;

@Service
@AllArgsConstructor
public class FacilityImageService {
    FacilityImageRepository facilityImageRepository;

    public void upload(FacilityImage facilityImage, MultipartFile uploadFile, int facilityCode) throws Exception {
        //windows 용
//        String path = "C:"+ Strings.PathString.FACILITY_IMAGE_FILE_PATH + "/" + facilityCode;
        //Linux 용
        String path = Strings.PathString.FACILITY_IMAGE_FILE_PATH + "/" + facilityCode;
        String fileName = "";

        fileName = uploadFile.getOriginalFilename();
        System.out.println(fileName + " was Uploaded.");
        if (fileName == null || fileName.isEmpty())
            throw new Exception("empty file");
        if (fileName.matches(".jpg"))
            throw new Exception("wrong mime type");
        try {
            facilityImage.setFileName("");
            facilityImage.setFacilityCode(facilityCode);
            facilityImageRepository.save(facilityImage);
            fileName = System.currentTimeMillis() + "_" + facilityImage.getId() + ".jpg";
            facilityImage.setFileName(fileName);
            facilityImageRepository.save(facilityImage);

            File directory = new File(path);
            if (!directory.exists()) {
                if (directory.mkdir()) {
                    System.out.println("Directory is created!");
                } else {
                    System.out.println("Failed to create directory!");
                }
            }

            System.out.println("UtilFile fileUpload fileName : " + fileName);
            System.out.println("UtilFile fileUpload uploadPath : " + path);

            File file = new File(path + "/" + fileName);
            uploadFile.transferTo(file);
        } catch (Exception e) {
            facilityImageRepository.deleteById(facilityImage.getId());
            throw e;
        }
    }
}
