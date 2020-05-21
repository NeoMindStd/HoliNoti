package com.neomind.holinoti_server.facility;

import org.springframework.data.geo.Point;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.jpa.repository.query.Procedure;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;


@Repository
public interface FacilityRepository extends JpaRepository<Facility, Integer>{
    public Facility findByPhoneNumber(String phoneNumber);


    @Procedure("Facility.findAllByCoordinates")
    List<Facility> findAllByCoordinates(@Param("lon") double x,@Param("lat") double y,@Param("side") int side );

}


