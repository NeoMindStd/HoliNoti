package com.neomind.holinoti_server.html;


import lombok.AllArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@AllArgsConstructor
public class HtmlController {
    @RequestMapping(value = "/kakao_map/x={x}/y={y}", method = RequestMethod.GET)
    public String map(@PathVariable("x") double x, @PathVariable("y") double y, ModelMap modelMap) throws Exception {
        modelMap.addAttribute("x",x);
        modelMap.addAttribute("y",y);

        System.out.println(x);
        System.out.println(y);

        System.out.println(modelMap.getAttribute("x"));
        System.out.println(modelMap.getAttribute("y"));

        return "kakao_map";
    }
}