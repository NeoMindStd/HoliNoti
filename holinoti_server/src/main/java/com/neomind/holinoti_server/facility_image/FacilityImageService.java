package com.neomind.holinoti_server.facility_image;

import com.neomind.holinoti_server.constants.Strings;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.FileOutputStream;
import java.io.IOException;

@Service
@AllArgsConstructor
public class FacilityImageService {
    public String upload(MultipartFile multipartFile, int facilityCode) {
        String url = null;

        try {
            // 파일 정보
            String originFilename = multipartFile.getOriginalFilename();
            assert originFilename != null;
            String extName = originFilename.substring(
                    originFilename.lastIndexOf("."), originFilename.length());
            long size = multipartFile.getSize();

            String path = Strings.PathString.FACILITIES_IMAGES_FULL_PATH + "/" + facilityCode + "/";

            // 서버에서 저장 할 파일 이름
            System.out.println("UtilFile fileUpload fileName : " + originFilename);
            System.out.println("UtilFile fileUpload uploadPath : " + path);
            String fileName = System.currentTimeMillis() + "_" + originFilename;

            System.out.println("originFilename : " + originFilename);
            System.out.println("extensionName : " + extName);
            System.out.println("size : " + size);
            System.out.println("saveFileName : " + fileName);

            boolean result = false;

            byte[] data = multipartFile.getBytes();
            FileOutputStream fos = new FileOutputStream(path + fileName);
            fos.write(data);
            fos.close();

            url = path + fileName;
        }
        catch (IOException e) {
            // 원래라면 RuntimeException 을 상속받은 예외가 처리되어야 하지만
            // 편의상 RuntimeException을 던진다.
            // throw new FileUploadException();
            throw new RuntimeException(e);
        }
        return url;
    }
}
