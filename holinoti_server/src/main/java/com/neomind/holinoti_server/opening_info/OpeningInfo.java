package com.neomind.holinoti_server.opening_info;

import lombok.*;

import javax.persistence.*;
import java.io.Serializable;

@Entity
@Data
@Table(name = "opening_info")
@Builder
@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class OpeningInfo implements Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id", nullable = false)
    private int id;
    @Column(name = "facility_code", nullable = false)
    private int facilityCode;
    @Column(name = "business_day_start")
    private String businessDayStart;
    @Column(name = "opening_hours_start")
    private String openingHoursStart;
    @Column(name = "business_day_end")
    private String businessDayEnd;
    @Column(name = "opening_hours_end")
    private String openingHoursEnd;
}