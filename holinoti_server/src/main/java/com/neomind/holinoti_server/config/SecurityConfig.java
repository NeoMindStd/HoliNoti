package com.neomind.holinoti_server.config;

import com.neomind.holinoti_server.user.Authority;
import com.neomind.holinoti_server.user.UserService;
import lombok.AllArgsConstructor;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.HttpMethod;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;

import static com.neomind.holinoti_server.constants.Strings.PathString;

@Configuration
@EnableWebSecurity
@AllArgsConstructor
public class SecurityConfig extends WebSecurityConfigurerAdapter {
    private UserService userService;

    @Bean
    public static PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }

    @Override
    protected void configure(HttpSecurity http) throws Exception {
        http.authorizeRequests()
                .antMatchers("/").permitAll()
                /// Facility
                .antMatchers(HttpMethod.GET, PathString.FACILITIES_URL).permitAll()
                .antMatchers(HttpMethod.GET, PathString.FACILITIES_URL_BY_CODE).permitAll()
                .antMatchers(HttpMethod.GET, PathString.FACILITIES_URL_BY_PHONE_NUMBER).permitAll()

                .antMatchers(HttpMethod.POST, PathString.FACILITIES_URL).hasAuthority(Authority.normal.name())

                .antMatchers(HttpMethod.PUT, PathString.FACILITIES_URL_BY_CODE).hasAuthority(Authority.normal.name())

                .antMatchers(HttpMethod.DELETE, PathString.FACILITIES_URL_BY_CODE).hasAuthority(Authority.normal.name())

                /// FacilityImage
                .antMatchers(HttpMethod.GET, PathString.FACILITIES_IMAGES_URL).hasAuthority(Authority.admin.name())
                .antMatchers(HttpMethod.GET, PathString.FACILITIES_IMAGES_URL_BY_ID).permitAll()
                .antMatchers(HttpMethod.GET,  PathString.FACILITIES_IMAGES_URL_BY_FACILITY_CODE).permitAll()

                .antMatchers(HttpMethod.POST, PathString.FACILITIES_IMAGES_URL).hasAuthority(Authority.normal.name())

                .antMatchers(HttpMethod.PUT, PathString.FACILITIES_IMAGES_URL_BY_ID).hasAuthority(Authority.normal.name())

                .antMatchers(HttpMethod.DELETE, PathString.FACILITIES_IMAGES_URL_BY_ID).hasAuthority(Authority.normal.name())

                /// OpeningInfo
                .antMatchers(HttpMethod.GET, PathString.OPENING_INFOS_URL).hasAuthority(Authority.admin.name())
                .antMatchers(HttpMethod.GET, PathString.OPENING_INFOS_URL_BY_ID).permitAll()
                .antMatchers(HttpMethod.GET, PathString.OPENING_INFOS_URL_BY_FACILITY_CODE).permitAll()

                .antMatchers(HttpMethod.POST, PathString.OPENING_INFOS_URL).hasAuthority(Authority.normal.name())

                .antMatchers(HttpMethod.PUT, PathString.OPENING_INFOS_URL_BY_ID).hasAuthority(Authority.normal.name())

                .antMatchers(HttpMethod.DELETE, PathString.OPENING_INFOS_URL_BY_ID).hasAuthority(Authority.normal.name())

                /// RelationAF
                .antMatchers(HttpMethod.GET, PathString.RELATION_AFS_URL).hasAuthority(Authority.admin.name())
                .antMatchers(HttpMethod.GET, PathString.RELATION_AFS_URL_BY_ID).permitAll()
                .antMatchers(HttpMethod.GET, PathString.RELATION_AFS_URL_BY_USER_ID).permitAll()
                .antMatchers(HttpMethod.GET, PathString.RELATION_AFS_URL_BY_FACILITY_CODE).permitAll()

                .antMatchers(HttpMethod.POST, PathString.RELATION_AFS_URL).hasAuthority(Authority.normal.name())

                .antMatchers(HttpMethod.PUT, PathString.RELATION_AFS_URL_BY_ID).hasAuthority(Authority.normal.name())

                .antMatchers(HttpMethod.DELETE, PathString.RELATION_AFS_URL_BY_ID).hasAuthority(Authority.normal.name())

                /// User
                .antMatchers(HttpMethod.GET, PathString.USER_URL).hasAuthority(Authority.admin.name())
                .antMatchers(HttpMethod.GET, PathString.USER_URL_BY_ACCOUNT).permitAll()
                .antMatchers(HttpMethod.GET, PathString.USER_URL_BY_EMAIL).permitAll()
                .antMatchers(HttpMethod.GET, PathString.USER_URL_BY_PHONE_NUMBER).permitAll()
                .antMatchers(HttpMethod.GET, PathString.USER_URL_BY_ID).hasAuthority(Authority.admin.name())

                .antMatchers(HttpMethod.POST, PathString.USER_LOGIN_URL).permitAll()
                .antMatchers(HttpMethod.POST, PathString.USER_REGISTER_URL).permitAll()

                .antMatchers(HttpMethod.PUT, PathString.USER_URL_BY_ID).hasAuthority(Authority.normal.name())

                .antMatchers(HttpMethod.DELETE, PathString.USER_URL_BY_ID).hasAuthority(Authority.normal.name())

                .and().csrf().disable().httpBasic();
    }

    @Override
    public void configure(AuthenticationManagerBuilder auth) throws Exception {
        auth.userDetailsService(userService).passwordEncoder(passwordEncoder());
    }
}
