package com.neomind.holinoti_server.facility;

import com.neomind.holinoti_server.relateion_af.RelationAF;
import com.neomind.holinoti_server.relateion_af.RelationAFRepository;
import com.neomind.holinoti_server.relateion_af.Role;
import com.neomind.holinoti_server.user.UserRepository;
import lombok.AllArgsConstructor;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@AllArgsConstructor
public class FacilityService {
    private UserRepository userRepository;
    private RelationAFRepository relationAFRepository;
    private FacilityRepository facilityRepository;

    public void linkSupervisorAndFacility(int fid) throws Exception {
        final String currentUserAccount = SecurityContextHolder.getContext().getAuthentication().getName();
        final int uid = userRepository.findByAccount(currentUserAccount).getId();
        relationAFRepository.save(
                RelationAF.builder()
                        .id(-1)
                        .facilityCode(fid)
                        .userId(uid)
                        .role(Role.supervisor)
                        .build()
        );
    }

    public void deleteAllRowInRelationAF(int code) {
        List<RelationAF> relationAFList = relationAFRepository.findByFacilityCode(code);
        relationAFRepository.deleteInBatch(relationAFList);
    }

    public List<Facility> queryByDistance(double x, double y, int side){
        return facilityRepository.findAllByCoordinates(x, y, side);
    }
}
