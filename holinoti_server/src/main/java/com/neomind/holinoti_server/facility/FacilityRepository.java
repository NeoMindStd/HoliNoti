package com.neomind.holinoti_server.facility;

import com.neomind.holinoti_server.manager.Manager;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface FacilityRepository extends JpaRepository<Facility, Integer> {
    public Manager findByPhoneNumber(String phoneNumber);
}