package com.neomind.holinoti_server.facility_image;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface FacilityImageRepository extends JpaRepository<FacilityImage, Integer> {
    public List<FacilityImage> findFacilityImagesByFacilityCode(int facilityCode);
}
