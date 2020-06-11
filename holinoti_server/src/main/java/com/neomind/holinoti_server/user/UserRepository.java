package com.neomind.holinoti_server.user;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface UserRepository extends JpaRepository<User, Integer> {
    public List<User> findByIdIn(List<Integer> id);

    public User findByAccount(String account);

    public User findByEmail(String email);

    public User findByPhoneNumber(String phoneNumber);
}