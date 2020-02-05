package com.neomind.holinoti_server.manager;

import lombok.*;

import javax.persistence.*;
import java.io.Serializable;

enum UserType {
    admin, employee, temporary;
}

@Entity
@Data
@Table(name = "manager")
@Builder
@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class Manager implements Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id", nullable = false)
    private int id;
    @Column(name = "account", nullable = false, unique = true)
    private String account;
    @Column(name = "password", nullable = false)
    private String password;
    @Column(name = "name")
    private String name;
    @Column(name = "facility_code")
    private int facilityCode;
    @Column(name = "user_type")
    @Enumerated(EnumType.STRING)
    private UserType userType;
}