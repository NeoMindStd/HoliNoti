package com.neomind.holinoti_server.facility;

import com.bedatadriven.jackson.datatype.jts.serialization.GeometryDeserializer;
import com.bedatadriven.jackson.datatype.jts.serialization.GeometrySerializer;
import com.fasterxml.jackson.databind.annotation.JsonDeserialize;
import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import lombok.*;
import org.locationtech.jts.geom.Point;

import javax.persistence.*;
import java.io.Serializable;

@Entity
@Data
@Table(name = "facility")
@Builder
@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class Facility implements Serializable {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "code", nullable = false)
    private int code;
    @Column(name = "name", nullable = false, unique = true)
    private String name;
    @Column(name = "address")
    private String address;
    @Column(name = "phone_number")
    private String phoneNumber;
    @Column(name = "site_url")
    private String siteUrl;
    @Column(name = "comment")
    private String comment;
    @Column(name = "opening_info")
    private String opening_info;
    @Column(name = "coordinates", nullable = false, columnDefinition = "geometry")
    @JsonSerialize(using = GeometrySerializer.class)
    @JsonDeserialize(contentUsing = GeometryDeserializer.class)
    private Point coordinates;
}

