package com.zyark.web.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * Created by ron on 17-5-15.
 */
@RequestMapping("page")
@Controller
public class RedirectController {
    //进行模块下页面的转发
    @RequestMapping(value = "/{param1}/{param2}")
    public String toPage(@PathVariable String param1, @PathVariable String param2){
        return "admin/" + param1 + "/" + param2;
    }


    @RequestMapping(value = "/{param1}")
    public String toPage(@PathVariable String param1){
        return "admin/" + param1 ;
    }
}
