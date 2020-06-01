package com.neomind.holinoti_server.user;

import com.neomind.holinoti_server.utils.EncodingManger;
import lombok.AllArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.net.URI;
import java.util.List;

import static com.neomind.holinoti_server.constants.Strings.PathString;
import static org.springframework.hateoas.server.mvc.WebMvcLinkBuilder.linkTo;

@RestController
@AllArgsConstructor
@RequestMapping(value = PathString.USER, consumes = MediaType.APPLICATION_JSON_VALUE, produces = MediaType.APPLICATION_JSON_VALUE)
public class UserController {
    UserRepository userRepository;
    UserService userService;

    @GetMapping
    public List<User> getAllUsers() {
        return userRepository.findAll();
    }

    @RequestMapping(path = PathString.LOGIN_PATH, method = RequestMethod.POST)
    public User login() throws Exception {
        System.out.println("login attempted...");
        User currentUser = userService.getCurrentUser();
        System.out.println("login:" + currentUser.toString());
        return currentUser;
    }

    @RequestMapping(path = "/compare/{account}/{password}", method = RequestMethod.GET)
    public boolean compareUser(@PathVariable("account") String account, @PathVariable("password") String password) throws Exception {
        return userService.isSameUser(account, password, userService.getCurrentUser());
    }

    @RequestMapping(path = PathString.ID_PATH + "{userId}", method = RequestMethod.GET)
    public User getUserById(@PathVariable("userId") int id) {
        return userRepository.findById(id).get();
    }

    @RequestMapping(path = PathString.ACCOUNT_PATH + "{userAccount}", method = RequestMethod.GET)
    public User getUserByAccount(@PathVariable("userAccount") String account) {
        return userRepository.findByAccount(account);
    }

    @RequestMapping(path = PathString.EMAIL_PATH + "{email}", method = RequestMethod.GET)
    public User getUserEmail(@PathVariable("email") String email) {
        return userRepository.findByEmail(email);
    }

    @RequestMapping(path = PathString.PHONE_NUMBER_PATH + "{phoneNumber}", method = RequestMethod.GET)
    public User getUserByPhoneNumber(@PathVariable("phoneNumber") String phoneNumber) {
        return userRepository.findByPhoneNumber(phoneNumber);
    }

    @RequestMapping(path = PathString.REGISTER_PATH, method = RequestMethod.POST)
    public ResponseEntity addUser(@RequestBody User user) {
        User newUser = userService.register(user);
        URI createdURI = linkTo(UserController.class).slash(newUser.getId()).toUri();
        return ResponseEntity.created(createdURI).body(newUser);
    }

    @RequestMapping(path = PathString.ID_PATH + "{userId}", method = RequestMethod.PUT)
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

    @RequestMapping(path = PathString.ID_PATH + "{userId}", method = RequestMethod.DELETE)
    public void deleteUser(@PathVariable("userId") int id) {
        userService.deleteAllRowInRelationAFByUser(id);
        userRepository.deleteById(id);
    }

    @RequestMapping(path = "/secession/{account}/{password}", method = RequestMethod.DELETE)
    public HttpStatus deleteUser(@PathVariable("account") String account, @PathVariable("password") String password) throws Exception {
        return userService.seceesion(account, password) ? HttpStatus.OK : HttpStatus.FORBIDDEN;
    }
}