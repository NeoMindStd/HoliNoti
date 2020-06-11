package com.neomind.holinoti_server.view;


import com.neomind.holinoti_server.constants.Strings;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@AllArgsConstructor
public class ViewController {
    @RequestMapping(value = Strings.PathString.KAKAO_MAP + Strings.PathString.X_PATH + "{x}" + Strings.PathString.Y_PATH + "{y}", method = RequestMethod.GET)
    public String map(@PathVariable("x") double x, @PathVariable("y") double y, ModelMap modelMap) throws Exception {
        modelMap.addAttribute("x", x);
        modelMap.addAttribute("y", y);

        System.out.println(x);
        System.out.println(y);

        System.out.println(modelMap.getAttribute("x"));
        System.out.println(modelMap.getAttribute("y"));

        return Strings.PathString.KAKAO_MAP_VIEW;
    }
}