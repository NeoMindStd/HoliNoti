package com.neomind.holinoti_server.manager;

import com.neomind.holinoti_server.utils.EncodingManger;
import lombok.AllArgsConstructor;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
@AllArgsConstructor
public class ManagerService implements UserDetailsService {
    private ManagerRepository managerRepository;

    public Manager signUp(Manager manager) {
        manager.setPassword(new EncodingManger().encode(manager.getPassword()));
        System.out.println(manager);
        return managerRepository.save(manager);
    }

    @Override
    public UserDetails loadUserByUsername(String account) throws UsernameNotFoundException {
        Manager manager = managerRepository.findByAccount(account);

        List<GrantedAuthority> authorities = new ArrayList<>();

        authorities.add(new SimpleGrantedAuthority(manager.getUserType().name()));

        return new User(manager.getAccount(), manager.getPassword(), authorities);
    }
}
