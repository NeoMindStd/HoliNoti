package com.neomind.holinoti_server.relateion_af;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface RelationAFRepository extends JpaRepository<RelationAF, Integer> {
    public List<RelationAF> findByUserId(int userId);

    public List<RelationAF> findByFacilityCode(int facilityCode);

    public List<RelationAF> findByUserIdAndFacilityCode(int userId, int facilityCode);
}