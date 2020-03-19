package com.neomind.holinoti_server.manager;

import com.neomind.holinoti_server.utils.Encrypter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.net.URI;
import java.util.List;

import static org.springframework.hateoas.server.mvc.WebMvcLinkBuilder.linkTo;

@RestController
@RequestMapping(value = "/managers", consumes = MediaType.APPLICATION_JSON_VALUE, produces = MediaType.APPLICATION_JSON_VALUE)
public class ManagerController {
    @Autowired
    ManagerRepository managerRepository;

    @GetMapping
    public List<Manager> getAllManagers() {
        return managerRepository.findAll();
    }

    @RequestMapping(path = "/id={managerId}", method = RequestMethod.GET)
    public Manager getManagerById(@PathVariable("managerId") int id) {
        return managerRepository.findById(id).get();
    }

    @RequestMapping(path = "/account={managerAccount}", method = RequestMethod.GET)
    public Manager getManagerByAccount(@PathVariable("managerAccount") String account) {
        return managerRepository.findByAccount(account);
    }

    @RequestMapping(path = "/facility_code={facilityCode}", method = RequestMethod.GET)
    public List<Manager> getManagerByAccount(@PathVariable("facilityCode") int facilityCode) {
        return managerRepository.findByFacilityCode(facilityCode);
    }

    @PostMapping
    public ResponseEntity addManager(@RequestBody Manager manager) {
        manager.setPassword(new Encrypter().encode(manager.getPassword()));
        System.out.println(manager);
        Manager newManager = managerRepository.save(manager);
        URI createdURI = linkTo(ManagerController.class).slash(newManager.getId()).toUri();
        return ResponseEntity.created(createdURI).body(newManager);
    }

    @RequestMapping(path = "/id={managerId}", method = RequestMethod.PUT)
    @ResponseStatus(HttpStatus.OK)
    public void updateManager(@RequestBody Manager manager,
                              @PathVariable("managerId") int id) {
        Manager target = managerRepository.findById(id).get();

        target.setAccount(manager.getAccount());
        target.setPassword(manager.getPassword() != null
                ? new Encrypter().encode(manager.getPassword()) : target.getPassword());
        target.setName(manager.getName());
        target.setFacilityCode(manager.getFacilityCode());
        target.setUserType(manager.getUserType());

        managerRepository.save(target);
    }

    @RequestMapping(path = "/id={managerId}", method = RequestMethod.DELETE)
    public void deleteManager(@PathVariable("managerId") int id) {
        managerRepository.deleteById(id);
    }
}