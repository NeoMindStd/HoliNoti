package com.neomind.holinoti_server.relateion_af;

import com.neomind.holinoti_server.facility.FacilityRepository;
import com.neomind.holinoti_server.facility.FacilityService;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

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
            if (rel.getRole() == Role.supervisor)
                isHaveSupervisor = true;
            //targetRelationAFList.add(rel);
        }
        if (!isHaveSupervisor) {
            facilityService.deleteAllRowInRelationAF(facilityCode);
            facilityRepository.deleteById(facilityCode);
        }
    }
}
