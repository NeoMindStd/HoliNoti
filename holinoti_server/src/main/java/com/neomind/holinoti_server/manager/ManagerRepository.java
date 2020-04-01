package com.neomind.holinoti_server.manager;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ManagerRepository extends JpaRepository<Manager, Integer> {
    public Manager findByAccount(String account);

    public List<Manager> findByFacilityCode(int facilityCode);

    public Manager findByPhoneNumber(String phoneNumber);
}