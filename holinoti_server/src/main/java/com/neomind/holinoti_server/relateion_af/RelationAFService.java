package com.neomind.holinoti_server.relateion_af;

import com.neomind.holinoti_server.facility.FacilityRepository;
import com.neomind.holinoti_server.facility.FacilityService;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.stream.Collectors;

@Service
@AllArgsConstructor
public class RelationAFService {
    private FacilityService facilityService;
    private FacilityRepository facilityRepository;
    private RelationAFRepository relationAFRepository;

    public void deleteAllFacilityWithoutSupervisor(int facilityCode) {
        List<RelationAF> relationAFListByFacilityCode = relationAFRepository.findByFacilityCode(facilityCode);
        boolean isHaveSupervisor = false;
        for (RelationAF rel : relationAFListByFacilityCode) {
            if (rel.getRole() == Role.supervisor) {
                isHaveSupervisor = true;
                break;
            }
            //targetRelationAFList.add(rel);
        }
        if (!isHaveSupervisor) {
            facilityService.deleteAllRowInRelationAF(facilityCode);
            facilityRepository.deleteById(facilityCode);
        }
    }

    public List<Integer> customerUserIdByFacilityCode(int facilityCode) {
        List<RelationAF> relationAFListByFacilityCode = relationAFRepository.findByFacilityCode(facilityCode);
        relationAFListByFacilityCode.removeIf(rel -> rel.getRole() != Role.customer);
        List<Integer> deviceTokens = relationAFListByFacilityCode.stream().map(RelationAF::getUserId).collect(Collectors.toList());
        HashSet<Integer> templist = new HashSet<Integer>(deviceTokens);
        deviceTokens = new ArrayList<Integer>(templist);

        return deviceTokens;
    }
}
