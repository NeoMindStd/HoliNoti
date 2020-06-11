package com.neomind.holinoti_server.notification;

import com.neomind.holinoti_server.constants.Strings;
import com.neomind.holinoti_server.relateion_af.RelationAFService;
import com.neomind.holinoti_server.user.UserService;
import lombok.AllArgsConstructor;
import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.client.ClientHttpRequestInterceptor;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import java.nio.charset.Charset;
import java.time.LocalDate;
import java.util.*;
import java.util.concurrent.CompletableFuture;

@Service
@AllArgsConstructor
public class NotificationService {
    RelationAFService relationAFService;
    UserService userService;

    @Async
    public CompletableFuture<String> send(String content) {

        RestTemplate restTemplate = new RestTemplate();

        ArrayList<ClientHttpRequestInterceptor> interceptors = new ArrayList<>();

        interceptors.add(new HeaderRequestInterceptor("Authorization", "key=" + Strings.Api.API_KEY_FCM_SERVER));
        interceptors.add(new HeaderRequestInterceptor("Content-Type", "application/json; charset=utf-8"));
        restTemplate.setInterceptors(interceptors);

        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(new MediaType("application", "json", Charset.forName("UTF-8")));
        HttpEntity<String> entity = new HttpEntity<>(content, headers);

        String firebaseResponse = restTemplate.postForObject(Strings.Api.API_URL_FCM_SERVER, entity, String.class);

        return CompletableFuture.completedFuture(firebaseResponse);
    }

    public String notificationJson(int facilityCode, String notificationTitle, String notificationBody) throws Exception {
        LocalDate localDate = LocalDate.now();

        List<Integer> userIds = relationAFService.userIdByFacilityCode(facilityCode);
        if (userIds.isEmpty()) throw new Exception("Not found");
        List<String> tokenList = userService.getDeviceTokensByIds(userIds);
        tokenList.removeIf(Objects::isNull);

        JSONObject body = new JSONObject();
        JSONArray array = new JSONArray();

        for (String s : tokenList) {
            array.put(s);
        }

        body.put("registration_ids", array);

        Map<String, String> notification = new HashMap<>();
        notification.put("title", notificationTitle);
        notification.put("body", notificationBody);

        body.put("notification", notification);

        System.out.println("Notification has been registered: " + body.toString());

        return body.toString();
    }
}
