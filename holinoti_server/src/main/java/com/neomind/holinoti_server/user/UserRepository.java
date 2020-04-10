package com.neomind.holinoti_server.user;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface UserRepository extends JpaRepository<User, Integer> {
    public User findByAccount(String account);

    public User findByEmail(String email);

    public User findByPhoneNumber(String phoneNumber);
}