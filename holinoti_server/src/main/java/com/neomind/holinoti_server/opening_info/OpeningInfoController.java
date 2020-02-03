package com.neomind.holinoti_server.opening_info;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Example;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.net.URI;
import java.util.List;

import static org.springframework.hateoas.mvc.ControllerLinkBuilder.linkTo;

@RestController
@RequestMapping(value = "/opening-infos", consumes = MediaType.APPLICATION_JSON_UTF8_VALUE, produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
public class OpeningInfoController {
    @Autowired
    OpeningInfoRepository openingInfoRepository;

    @GetMapping
    public List<OpeningInfo> getAllOpeningInfos(){
        return openingInfoRepository.findAll();
    }

    @RequestMapping(path = "/id={id}", method = RequestMethod.GET)
    public OpeningInfo getOpeningInfo(@PathVariable("id") int id){
        return openingInfoRepository.findById(id).get();
    }

    @RequestMapping(path = "/facility_code={facilityCode}", method = RequestMethod.GET)
    public List<OpeningInfo> getOpeningInfos(@PathVariable("facilityCode") int facilityCode){
        return openingInfoRepository.findOpeningInfosByFacilityCode(facilityCode);
    }

    @PostMapping
    public ResponseEntity addOpeningInfo(@RequestBody OpeningInfo openingInfo) {
        System.out.println(openingInfo);
        OpeningInfo newOpeningInfo = openingInfoRepository.save(openingInfo);
        URI createdURI = linkTo(OpeningInfoController.class).slash(newOpeningInfo.getFacilityCode()).toUri();
        return ResponseEntity.created(createdURI).body(newOpeningInfo);
    }

    @RequestMapping(path = "/{facilityCode}", method = RequestMethod.PUT)
    @ResponseStatus(HttpStatus.OK)
    public void updateOpeningInfo(@RequestBody OpeningInfo openingInfo,
                                  @PathVariable("facilityCode") int id) {
        OpeningInfo target = openingInfoRepository.findById(id).get();

        target.setFacilityCode(openingInfo.getFacilityCode());
        target.setBusinessDayStart(openingInfo.getBusinessDayStart());
        target.setOpeningHoursStart(openingInfo.getOpeningHoursStart());
        target.setBusinessDayEnd(openingInfo.getBusinessDayEnd());
        target.setOpeningHoursEnd(openingInfo.getOpeningHoursEnd());

        openingInfoRepository.save(target);
    }

    @RequestMapping(path = "/{managerId}", method = RequestMethod.DELETE)
    public void deleteOpeningInfo(@PathVariable("managerId") int id){
        openingInfoRepository.deleteById(id);
    }
}