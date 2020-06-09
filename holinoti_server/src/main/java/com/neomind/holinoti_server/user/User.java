package com.neomind.holinoti_server.user;

import lombok.*;

import javax.persistence.*;
import javax.validation.constraints.Email;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Pattern;
import java.io.Serializable;

@Entity
@Data
@Table(name = "user")
@Builder
@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class User implements Serializable {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id", nullable = false)
    private int id;

    @Column(name = "account", nullable = false, unique = true)
    @NotBlank(message = "아이디는 필수 입력 값입니다.")
    private String account;

    @NotBlank(message = "비밀번호는 필수 입력 값입니다.")
    @Pattern(regexp="^(?:(?=.*?[a-zA-Z])(?=.*?[0-9])|(?=.*?[0-9])(?=.*?[!@#\\$&*~])|(?=.*?[a-zA-Z])(?=.*?[!@#\\$&*~]))[A-Za-z0-9!@#\\$&*~]{8,20}$",
            message = "비밀번호는 영문자와 숫자, 특수기호(!,@,#,\\,$,&,*,~) 중 적어도 2종류 이상 포함된 8자 ~ 20자의 비밀번호여야 합니다.")
    @Column(name = "password", nullable = false)
    private String password;

    @NotBlank(message = "이름은 필수 입력 값입니다.")
    @Column(name = "name")
    private String name;

    @Column(name = "authority", nullable = false)
    @Enumerated(EnumType.STRING)
    private Authority authority;

    @NotBlank(message = "이메일은 필수 입력 값입니다.")
    @Email(message = "이메일 형식에 맞지 않습니다.")
    @Column(name = "email")
    private String email;

    @NotBlank(message = "휴대전화 번호는 필수 입력 값입니다.")
    @Column(name = "phone_number")
    private String phoneNumber;

    @Column(name = "device_token")
    private String deviceToken;
}