package com.neomind.holinoti_server.notification;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.Collections;
import java.util.List;
import java.util.Objects;
import java.util.concurrent.CompletableFuture;
import java.util.concurrent.ExecutionException;
import java.util.stream.Collectors;

import com.neomind.holinoti_server.constants.Strings;
import com.neomind.holinoti_server.relateion_af.RelationAFService;
import com.neomind.holinoti_server.user.User;
import com.neomind.holinoti_server.user.UserRepository;
import com.neomind.holinoti_server.user.UserService;
import lombok.AllArgsConstructor;
import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.*;
import org.springframework.web.bind.annotation.*;

@RestController
@AllArgsConstructor
//TODO consumes 확인하기
@RequestMapping(value = Strings.PathString.NOTIFICATION, produces = MediaType.APPLICATION_JSON_VALUE)
public class NotificationController {
    UserService userService;
    RelationAFService relationAFService;
//    @Autowired
    NotificationService notificationService;


//    //TODO 생성되는 JSON 알림 객체. device 토큰을 불러올 facility_code를 매개변수로 받아야함.
//    public String PeriodicNotificationJson(int facilityCode, LocalDateTime holyDateTime) throws Exception {
//        LocalDate localDate = LocalDate.now();
//
//        List<Integer> userIds = relationAFService.customerUserIdByFacilityCode(facilityCode);
//        if(userIds.isEmpty())
//            throw new Exception("No ids found");
//        List<String> tokenList = userService.getDeviceTokensByIds(userIds);
//        tokenList.removeIf(Objects::isNull);
////        String[] deviceTokens = {"device token value 1","device token value 2","device token value 3"};
//
//        JSONObject body = new JSONObject();
//
////        List<String> tokenList = new ArrayList<String>();
//
////        Collections.addAll(tokenList, deviceTokens);
//
//        JSONArray array = new JSONArray();
//
//        for (String s : tokenList) {
//            array.put(s);
//        }
//
//        body.put("registration_ids", array);
//
//        JSONObject notification = new JSONObject();
//        notification.put("title","hello!");
//        notification.put("body","Today is "+localDate.getDayOfWeek().name()+"!");
//
//        body.put("notification", notification);
//
//        System.out.println(body.toString());
//
//        return body.toString();
//    }
    //TODO SecurityConfig 추가해야됨.
    @RequestMapping(path = Strings.PathString.FACILITY_CODE_PATH + "{facilityCode}" +
            Strings.PathString.HOLYDAY + "{HolyDay}", method = RequestMethod.GET)
    //TODO facility_code를 매개변수로 받아야함. Manager 이상이 접근할 수 있게 해야함. magnager 이상이 자신이 관리가능한 범위에 알림이 가능해야함.
    public @ResponseBody ResponseEntity<String> send(@DateTimeFormat(pattern = "yyyy-MM-dd'T'HH:mm:ss")
                                                     @PathVariable("HolyDay") LocalDateTime holyDateTime,
                                                     @PathVariable("facilityCode") int facilityCode) throws Exception {
        if (!userService.isAccessible(facilityCode))
            throw new Exception("Prohibited: Low Grade Role");
        String notifications = notificationService.PeriodicNotificationJson(facilityCode, holyDateTime);

        HttpEntity<String> request = new HttpEntity<>(notifications);

        CompletableFuture<String> pushNotification = notificationService.send(request);
        CompletableFuture.allOf(pushNotification).join();

        try{
            String firebaseResponse = pushNotification.get();
            return new ResponseEntity<>(firebaseResponse, HttpStatus.OK);
        }
        catch (InterruptedException e){
            throw new InterruptedException();
        }
        catch (ExecutionException e){
            return new ResponseEntity<>("Push Notification ERROR!", HttpStatus.BAD_REQUEST);
        }
    }
}