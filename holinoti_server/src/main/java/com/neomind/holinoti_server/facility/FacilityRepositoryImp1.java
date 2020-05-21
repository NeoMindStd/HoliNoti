//package com.neomind.holinoti_server.facility;
//
//import javax.persistence.EntityManager;
//import javax.persistence.PersistenceContext;
//import javax.persistence.StoredProcedureQuery;
//import java.util.List;
//
//public class FacilityRepositoryImp1 implements FacilityRepositoryCustom{
//    @PersistenceContext
//    private EntityManager em;
//
//
//    @Override
//    public List<Facility> findAllByCoordinates(double x, double y, int side) {
//        StoredProcedureQuery findByDistanceProcedure =
//                em.createNamedStoredProcedureQuery("findAllByCoordinates");
//        return findByDistanceProcedure.getResultList();
//    }
//
//
//
//}
