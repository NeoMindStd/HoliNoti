package com.neomind.holinoti_server.config;

import com.neomind.holinoti_server.constants.Strings;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class WebMvcConfig implements WebMvcConfigurer {
    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        registry.addResourceHandler(Strings.PathString.FACILITIES_IMAGES_FULL_PATH + "/**")
                .addResourceLocations("file:" + Strings.PathString.FACILITY_IMAGE_FILE_PATH + "/");
    }
    //Windows용
//    public void addResourceHandlers(ResourceHandlerRegistry registry) {
//        registry.addResourceHandler(Strings.PathString.FACILITIES_IMAGES_FULL_PATH + "/**")
//                .addResourceLocations("file:///C" + Strings.PathString.FACILITY_IMAGE_FILE_PATH + "/");
//    }
}