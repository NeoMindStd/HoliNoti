package com.neomind.holinoti_server.opening_info;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface OpeningInfoRepository extends JpaRepository<OpeningInfo, Integer> {
    public List<OpeningInfo> findOpeningInfosByFacilityCode(int facilityCode);
}