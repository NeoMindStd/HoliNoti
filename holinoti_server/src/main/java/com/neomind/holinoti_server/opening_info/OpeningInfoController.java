package com.neomind.holinoti_server.opening_info;

import com.neomind.holinoti_server.user.UserService;
import lombok.AllArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.net.URI;
import java.util.List;

import static org.springframework.hateoas.server.mvc.WebMvcLinkBuilder.linkTo;
import static com.neomind.holinoti_server.constants.Strings.PathString;

@RestController
@AllArgsConstructor
@RequestMapping(value = PathString.OPENING_INFOS, consumes = MediaType.APPLICATION_JSON_VALUE, produces = MediaType.APPLICATION_JSON_VALUE)
public class OpeningInfoController {
    OpeningInfoRepository openingInfoRepository;
    UserService userService;

    @GetMapping
    public List<OpeningInfo> getAllOpeningInfos() {
        return openingInfoRepository.findAll();
    }

    @RequestMapping(path = PathString.ID_PATH + "{openingInfoId}", method = RequestMethod.GET)
    public OpeningInfo getOpeningInfo(@PathVariable("openingInfoId") int id) {
        return openingInfoRepository.findById(id).get();
    }

    @RequestMapping(path = PathString.FACILITY_CODE_PATH + "{facilityCode}", method = RequestMethod.GET)
    public List<OpeningInfo> getOpeningInfosByFacilityCode(@PathVariable("facilityCode") int facilityCode) {
        return openingInfoRepository.findOpeningInfosByFacilityCode(facilityCode);
    }

    @PostMapping
    public ResponseEntity addOpeningInfo(@RequestBody OpeningInfo openingInfo) throws Exception {
        if (!userService.isAccessible(openingInfo.getFacilityCode())) throw new Exception("Prohibited: Low Grade Role");
        System.out.println(openingInfo);
        OpeningInfo newOpeningInfo = openingInfoRepository.save(openingInfo);
        URI createdURI = linkTo(OpeningInfoController.class).slash(newOpeningInfo.getFacilityCode()).toUri();
        return ResponseEntity.created(createdURI).body(newOpeningInfo);
    }

    @RequestMapping(path = PathString.ID_PATH + "{openingInfoId}", method = RequestMethod.PUT)
    @ResponseStatus(HttpStatus.OK)
    public void updateOpeningInfo(@RequestBody OpeningInfo openingInfo,
                                  @PathVariable("openingInfoId") int id) throws Exception {
        if (!userService.isAccessible(openingInfo.getFacilityCode())) throw new Exception("Prohibited: Low Grade Role");
        OpeningInfo target = openingInfoRepository.findById(id).get();

        target.setFacilityCode(openingInfo.getFacilityCode());
        target.setBusinessDayStart(openingInfo.getBusinessDayStart());
        target.setOpeningHoursStart(openingInfo.getOpeningHoursStart());
        target.setBusinessDayEnd(openingInfo.getBusinessDayEnd());
        target.setOpeningHoursEnd(openingInfo.getOpeningHoursEnd());

        openingInfoRepository.save(target);
    }

    @RequestMapping(path = PathString.ID_PATH + "{openingInfoId}", method = RequestMethod.DELETE)
    public void deleteOpeningInfo(@PathVariable("openingInfoId") int id) throws Exception {
        if (!userService.isAccessible(openingInfoRepository.findById(id).get().getFacilityCode()))
            throw new Exception("Prohibited: Low Grade Role");
        openingInfoRepository.deleteById(id);
    }
}