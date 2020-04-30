package com.neomind.holinoti_server;

import com.neomind.holinoti_server.utils.MDToHtmlConverter;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.boot.web.servlet.support.SpringBootServletInitializer;

import java.io.IOException;

@SpringBootApplication
public class RestApiApplication extends SpringBootServletInitializer {

    public static void main(String[] args) {
        try {
            new MDToHtmlConverter().renderAllMarkdowns();
        } catch (IOException e) {
            e.printStackTrace();
        }
        SpringApplication.run(RestApiApplication.class, args);
    }

    @Override
    protected SpringApplicationBuilder configure(SpringApplicationBuilder application) {
        return application.sources(RestApiApplication.class);
    }
}