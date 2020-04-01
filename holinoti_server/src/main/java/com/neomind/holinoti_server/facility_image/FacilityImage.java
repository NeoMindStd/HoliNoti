package com.neomind.holinoti_server.facility_image;

import lombok.*;

import javax.persistence.*;
import java.io.Serializable;

@Entity
@Data
@Table(name = "facility_image")
@Builder
@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class FacilityImage implements Serializable {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id", nullable = false)
    private int id;
    @Column(name = "image", nullable = false, unique = true)
    private String image;
    @Column(name = "facility_code")
    private int facilityCode;
}
