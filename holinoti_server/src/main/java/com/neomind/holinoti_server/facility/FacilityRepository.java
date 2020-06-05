package com.neomind.holinoti_server.facility;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;


@Repository
public interface FacilityRepository extends JpaRepository<Facility, Integer> {
    public Facility findByPhoneNumber(String phoneNumber);

    @Query(value = "CALL DISTANCE(:lon, :lat, :side);", nativeQuery = true)
    List<Facility> findAllByCoordinates(@Param("lon") double x, @Param("lat") double y, @Param("side") int side);

    @Query(value = "CALL NAMEDISTANCE(:lon, :lat, :side, :nam);", nativeQuery = true)
    List<Facility> findAllByName(@Param("lon") double x, @Param("lat") double y, @Param("side") int side, @Param("nam") String nam);
}


