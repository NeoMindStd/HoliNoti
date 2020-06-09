package com.neomind.holinoti_server.notification;

import com.neomind.holinoti_server.relateion_af.RelationAFService;
import com.neomind.holinoti_server.user.UserService;
import lombok.AllArgsConstructor;
import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.http.HttpEntity;
import org.springframework.http.client.ClientHttpRequestInterceptor;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;
import java.util.concurrent.CompletableFuture;

@Service
@AllArgsConstructor
public class NotificationService {
    private static final String firebase_server_key = "AAAAHmLOi9s:APA91bFvXcg0LzYrp4tCYA6zdTDdGVZ3Tqbx0i0tAuKlQEN3fsAGPXnbO_B5SBH2JMAtmHVjetHJom6x2FcAddi_ZWuv4fvbAbyqCyBosOSPYd3VCvMPp6dPCJ_CjVJHEGAxhX2s-sKq";
    private static final String firebase_api_url = "https://fcm.googleapis.com/fcm/send";

    RelationAFService relationAFService;
    UserService userService;

    @Async
    public CompletableFuture<String> send(HttpEntity<String> entity) {

        RestTemplate restTemplate = new RestTemplate();

        ArrayList<ClientHttpRequestInterceptor> interceptors = new ArrayList<>();

        interceptors.add(new HeaderRequestInterceptor("Authorization", "key=" + firebase_server_key));
        interceptors.add(new HeaderRequestInterceptor("Content-Type", "application/json; UTF-8 "));
        restTemplate.setInterceptors(interceptors);

        String firebaseResponse = restTemplate.postForObject(firebase_api_url, entity, String.class);

        return CompletableFuture.completedFuture(firebaseResponse);
    }

    //TODO 생성되는 JSON 알림 객체. device 토큰을 불러올 facility_code를 매개변수로 받아야함.
    public String PeriodicNotificationJson(int facilityCode, LocalDateTime holyDateTime) throws Exception {
        LocalDate localDate = LocalDate.now();

        List<Integer> userIds = relationAFService.customerUserIdByFacilityCode(facilityCode);
        if (userIds.isEmpty())
            throw new Exception("No ids found");
        List<String> tokenList = userService.getDeviceTokensByIds(userIds);
        tokenList.removeIf(Objects::isNull);
//        String[] deviceTokens = {"device token value 1","device token value 2","device token value 3"};

        JSONObject body = new JSONObject();

//        List<String> tokenList = new ArrayList<String>();

//        Collections.addAll(tokenList, deviceTokens);

        JSONArray array = new JSONArray();

        for (String s : tokenList) {
            array.put(s);
        }

        body.put("registration_ids", array);

        JSONObject notification = new JSONObject();
        notification.put("title", "hello!");
        notification.put("body", "Today is " + localDate.getDayOfWeek().name() + "!");

        body.put("notification", notification);

        System.out.println(body.toString());

        return body.toString();
    }
}
