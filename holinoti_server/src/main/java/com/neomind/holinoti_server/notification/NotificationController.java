package com.neomind.holinoti_server.notification;

import com.neomind.holinoti_server.constants.Strings;
import com.neomind.holinoti_server.relateion_af.RelationAFService;
import com.neomind.holinoti_server.user.UserService;
import lombok.AllArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.concurrent.CompletableFuture;
import java.util.concurrent.ExecutionException;

@RestController
@AllArgsConstructor
@RequestMapping(value = Strings.PathString.NOTIFICATIONS, consumes = MediaType.APPLICATION_JSON_VALUE, produces = MediaType.APPLICATION_JSON_VALUE)
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

    @RequestMapping(path = Strings.PathString.FACILITY_CODE_PATH + "{facilityCode}", method = RequestMethod.POST)
    public @ResponseBody
    ResponseEntity<String> send(@PathVariable("facilityCode") int facilityCode, @RequestBody Notification notification) throws Exception {
        if (!userService.isAccessible(facilityCode))
            throw new Exception("Prohibited: Low Grade Role");
        String notifications = notificationService.notificationJson(facilityCode, notification.getTitle(), notification.getBody());

        CompletableFuture<String> pushNotification = notificationService.send(notifications);
        CompletableFuture.allOf(pushNotification).join();

        try {
            String firebaseResponse = pushNotification.get();
            return new ResponseEntity<>(firebaseResponse, HttpStatus.OK);
        } catch (InterruptedException e) {
            throw new InterruptedException();
        } catch (ExecutionException e) {
            return new ResponseEntity<>("Push Notification ERROR!", HttpStatus.BAD_REQUEST);
        }
    }
}