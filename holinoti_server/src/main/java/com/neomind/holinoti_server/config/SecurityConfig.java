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
                /// Resources
                .antMatchers(HttpMethod.GET, "/kakao_map.html/**").permitAll()

                /// Facility
                .antMatchers(HttpMethod.GET, "/facilities/**").permitAll()
                .antMatchers(HttpMethod.GET, "/facilities/code=*/**").permitAll()
                .antMatchers(HttpMethod.GET, "/facilities/phone_number=*/**").permitAll()

                .antMatchers(HttpMethod.POST, "/facilities/**").hasAuthority(Authority.normal.name())

                .antMatchers(HttpMethod.PUT, "/facilities/code=*/**").hasAuthority(Authority.normal.name())

                .antMatchers(HttpMethod.DELETE, "/facilities/code=*/**").hasAuthority(Authority.normal.name())

                /// FacilityImage
                .antMatchers(HttpMethod.GET, "/facilities/facility_images/**").hasAuthority(Authority.admin.name())
                .antMatchers(HttpMethod.GET, "/facilities/facility_images/id=*/**").permitAll()
                .antMatchers(HttpMethod.GET, "/facilities/facility_images/facility_code=*/**").permitAll()

                .antMatchers(HttpMethod.POST, "/facilities/facility_images/**").hasAuthority(Authority.normal.name())

                .antMatchers(HttpMethod.PUT, "/facilities/facility_images/id=*/**").hasAuthority(Authority.normal.name())

                .antMatchers(HttpMethod.DELETE, "/facilities/facility_images/id=*/**").hasAuthority(Authority.normal.name())

                /// OpeningInfo
                .antMatchers(HttpMethod.GET, "/opening-infos/**").hasAuthority(Authority.admin.name())
                .antMatchers(HttpMethod.GET, "/opening-infos/id=*/**").permitAll()
                .antMatchers(HttpMethod.GET, "/opening-infos/facility_code=*/**").permitAll()

                .antMatchers(HttpMethod.POST, "/opening-infos/**").hasAuthority(Authority.normal.name())

                .antMatchers(HttpMethod.PUT, "/opening-infos/id=*/**").hasAuthority(Authority.normal.name())

                .antMatchers(HttpMethod.DELETE, "/opening-infos/id=*/**").hasAuthority(Authority.normal.name())

                /// RelationAF
                .antMatchers(HttpMethod.GET, "/relation_afs/**").hasAuthority(Authority.admin.name())
                .antMatchers(HttpMethod.GET, "/relation_afs/id=*/**").permitAll()
                .antMatchers(HttpMethod.GET, "/relation_afs/user_id=*/**").permitAll()
                .antMatchers(HttpMethod.GET, "/relation_afs/facility_code=*/**").permitAll()

                .antMatchers(HttpMethod.POST, "/relation_afs/**").hasAuthority(Authority.normal.name())

                .antMatchers(HttpMethod.PUT, "/relation_afs/id=*/**").hasAuthority(Authority.normal.name())

                .antMatchers(HttpMethod.DELETE, "/relation_afs/id=*/**").hasAuthority(Authority.normal.name())

                /// User
                .antMatchers(HttpMethod.GET, "/users/**").hasAuthority(Authority.admin.name())
                .antMatchers(HttpMethod.GET, "/users/account=*/**").permitAll()
                .antMatchers(HttpMethod.GET, "/users/email=*/**").permitAll()
                .antMatchers(HttpMethod.GET, "/users/phone_number=*/**").permitAll()
                .antMatchers(HttpMethod.GET, "/users/id=*/**").hasAuthority(Authority.admin.name())

                .antMatchers(HttpMethod.POST, "/users/login/**").permitAll()
                .antMatchers(HttpMethod.POST, "/users/register/**").permitAll()

                .antMatchers(HttpMethod.PUT, "/users/id=*/**").hasAuthority(Authority.normal.name())

                .antMatchers(HttpMethod.DELETE, "/users/id=*/**").hasAuthority(Authority.normal.name())

                .and().csrf().disable().httpBasic();
    }

    @Override
    public void configure(AuthenticationManagerBuilder auth) throws Exception {
        auth.userDetailsService(userService).passwordEncoder(passwordEncoder());
    }
}
