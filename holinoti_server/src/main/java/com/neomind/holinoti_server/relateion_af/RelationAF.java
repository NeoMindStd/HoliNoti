package com.neomind.holinoti_server.relateion_af;

import lombok.*;

import javax.persistence.*;
import java.io.Serializable;

@Entity
@Data
@Table(name = "relation_af")
@Builder
@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class RelationAF implements Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id", nullable = false)
    private int id;
    @Column(name = "user_id", nullable = false)
    private int userId;
    @Column(name = "facility_code", nullable = false)
    private int facilityCode;
    @Column(name = "role", nullable = false)
    @Enumerated(EnumType.STRING)
    private Role role;
}