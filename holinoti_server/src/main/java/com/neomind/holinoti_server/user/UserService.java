package com.neomind.holinoti_server.user;

import com.neomind.holinoti_server.relateion_af.RelationAFRepository;
import com.neomind.holinoti_server.relateion_af.Role;
import com.neomind.holinoti_server.utils.EncodingManger;
import lombok.AllArgsConstructor;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
@AllArgsConstructor
public class UserService implements UserDetailsService {
    private static RelationAFRepository relationAFRepository;
    private UserRepository userRepository;

    public static Role getUserRoleOfFacility(int uid, int fid) {
        return relationAFRepository.findByUserIdAndFacilityCode(uid, fid).get(0).getRole();
    }

    public static boolean isAccessible(int uid, int fid, Role role) {
        return getUserRoleOfFacility(uid, fid).ordinal() <= role.ordinal();
    }

    public User register(User user) {
        user.setPassword(new EncodingManger().encode(user.getPassword()));

        System.out.println("Registered a user: " + user);

        return userRepository.save(user);
    }

    public User getCurrentUser() throws Exception {
        final String currentUserAccount = SecurityContextHolder.getContext().getAuthentication().getName();
        System.out.println("Login:" + currentUserAccount);
        if (currentUserAccount == null || currentUserAccount.equals("anonymousUser") || currentUserAccount.equals("")) {
            throw new Exception("Bad Account");
        }
        return userRepository.findByAccount(currentUserAccount);
    }

    @Override
    public UserDetails loadUserByUsername(String account) throws UsernameNotFoundException {
        User user = userRepository.findByAccount(account);

        List<GrantedAuthority> authorities = new ArrayList<>();

        for (int i = user.getAuthority().ordinal(); i < Authority.values().length; i++) {
            authorities.add(new SimpleGrantedAuthority(Authority.values()[i].name()));
        }

        return new org.springframework.security.core.userdetails.
                User(user.getAccount(), user.getPassword(), authorities);
    }
}
