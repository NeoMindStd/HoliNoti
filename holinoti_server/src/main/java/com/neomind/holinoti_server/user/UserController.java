package com.neomind.holinoti_server.user;

import com.neomind.holinoti_server.utils.EncodingManger;
import lombok.AllArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.net.URI;
import java.util.List;

import static org.springframework.hateoas.server.mvc.WebMvcLinkBuilder.linkTo;

@RestController
@AllArgsConstructor
@RequestMapping(value = "/users", consumes = MediaType.APPLICATION_JSON_VALUE, produces = MediaType.APPLICATION_JSON_VALUE)
public class UserController {
    UserRepository userRepository;
    UserService userService;

    @GetMapping
    public List<User> getAllUsers() {
        return userRepository.findAll();
    }

    @RequestMapping(path = "/login", method = RequestMethod.POST)
    public User login() throws Exception {
        return userService.getCurrentUser();
    }

    @RequestMapping(path = "/id={userId}", method = RequestMethod.GET)
    public User getUserById(@PathVariable("userId") int id) {
        return userRepository.findById(id).get();
    }

    @RequestMapping(path = "/account={userAccount}", method = RequestMethod.GET)
    public User getUserByAccount(@PathVariable("userAccount") String account) {
        return userRepository.findByAccount(account);
    }

    @RequestMapping(path = "/email={email}", method = RequestMethod.GET)
    public User getUserEmail(@PathVariable("email") String email) {
        return userRepository.findByEmail(email);
    }

    @RequestMapping(path = "/phone_number={phoneNumber}", method = RequestMethod.GET)
    public User getUserByPhoneNumber(@PathVariable("phoneNumber") String phoneNumber) {
        return userRepository.findByPhoneNumber(phoneNumber);
    }

    @RequestMapping(path = "/register", method = RequestMethod.POST)
    public ResponseEntity addUser(@RequestBody User user) {
        User newUser = userService.register(user);
        URI createdURI = linkTo(UserController.class).slash(newUser.getId()).toUri();
        return ResponseEntity.created(createdURI).body(newUser);
    }

    @RequestMapping(path = "/id={userId}", method = RequestMethod.PUT)
    @ResponseStatus(HttpStatus.OK)
    public void updateUser(@RequestBody User user,
                           @PathVariable("userId") int id) {
        User target = userRepository.findById(id).get();

        target.setAccount(user.getAccount());
        target.setPassword(user.getPassword() != null
                ? new EncodingManger().encode(user.getPassword()) : target.getPassword());
        target.setName(user.getName());
        target.setAuthority(user.getAuthority());
        target.setEmail(user.getEmail());
        target.setPhoneNumber(user.getPhoneNumber());

        userRepository.save(target);
    }

    @RequestMapping(path = "/id={userId}", method = RequestMethod.DELETE)
    public void deleteUser(@PathVariable("userId") int id) {
        userRepository.deleteById(id);
    }
}