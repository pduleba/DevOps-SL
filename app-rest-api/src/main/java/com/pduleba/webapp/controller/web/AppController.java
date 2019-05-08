package com.pduleba.webapp.controller.web;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

@Controller
public class AppController {

    @GetMapping({"/", "/index"})
    public String index(Model modal) {
        modal.addAttribute("title", "App");
        return "index";
    }

    @GetMapping("/partials/{page}")
    public String partialHandler(@PathVariable("page") final String page) {
        return page;
    }

}
