package com.neomind.holinoti_server.notification;

import lombok.*;

import java.io.Serializable;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class Notification implements Serializable {
    private String title;
    private String body;
}
