package com.neomind.holinoti_server.config;

import com.neomind.holinoti_server.manager.ManagerService;
import com.neomind.holinoti_server.manager.UserType;
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
    private ManagerService managerService;

    @Bean
    public static PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }

    @Override
    protected void configure(HttpSecurity http) throws Exception {
        // TODO Auto-generated method stub
        http.authorizeRequests()
                .antMatchers("/").permitAll()
                .antMatchers(HttpMethod.GET,"/managers/login").permitAll()
                .antMatchers(HttpMethod.GET,"/managers/account=*").permitAll()
                .antMatchers(HttpMethod.POST,"/managers/register").permitAll()
                .antMatchers(HttpMethod.GET,"/facilities").permitAll()
                .antMatchers(HttpMethod.GET,"/facilities/code=*").permitAll()
                .antMatchers(HttpMethod.GET,"/opening-infos").permitAll()
                .antMatchers(HttpMethod.GET,"/opening-infos/id=*").permitAll()
                .antMatchers(HttpMethod.GET,"/opening-infos/facility_code=*").permitAll()

                .antMatchers(HttpMethod.GET,"/managers/facility_code=*").hasAuthority(UserType.employee.name())
                .antMatchers(HttpMethod.PUT,"/managers/id=*").hasAuthority(UserType.employee.name())
                .antMatchers(HttpMethod.DELETE,"/managers/id=*").hasAuthority(UserType.employee.name())
                .antMatchers(HttpMethod.PUT,"/facilities/code=*").hasAuthority(UserType.employee.name())
                .antMatchers(HttpMethod.POST,"/opening-infos/code=*").hasAuthority(UserType.employee.name())
                .antMatchers(HttpMethod.PUT,"/opening-infos/code=*").hasAuthority(UserType.employee.name())
                .antMatchers(HttpMethod.DELETE,"/opening-infos/code=*").hasAuthority(UserType.employee.name())

                .antMatchers(HttpMethod.POST,"/facilities").hasAuthority(UserType.manager.name())
                .antMatchers(HttpMethod.DELETE,"/facilities/code=*").hasAuthority(UserType.manager.name())

                .antMatchers(HttpMethod.GET,"/managers").hasAuthority(UserType.admin.name())
                .antMatchers(HttpMethod.GET,"/managers/id=*").hasAuthority(UserType.admin.name());
    }

    @Override
    public void configure(AuthenticationManagerBuilder auth) throws Exception {
        auth.userDetailsService(managerService).passwordEncoder(passwordEncoder());
    }
}
