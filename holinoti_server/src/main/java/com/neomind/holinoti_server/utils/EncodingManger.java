package com.neomind.holinoti_server.utils;

import com.neomind.holinoti_server.config.SecurityConfig;
import org.springframework.security.crypto.password.PasswordEncoder;

public class EncodingManger implements PasswordEncoder {
    private PasswordEncoder passwordEncoder;

    public EncodingManger() {
        this.passwordEncoder = SecurityConfig.passwordEncoder();
    }

    public EncodingManger(PasswordEncoder passwordEncoder) {
        this.passwordEncoder = passwordEncoder;
    }

    @Override
    public String encode(CharSequence rawPassword) {
        return passwordEncoder.encode(rawPassword);
    }

    @Override
    public boolean matches(CharSequence rawPassword, String encodedPassword) {
        return passwordEncoder.matches(rawPassword, encodedPassword);
    }
}