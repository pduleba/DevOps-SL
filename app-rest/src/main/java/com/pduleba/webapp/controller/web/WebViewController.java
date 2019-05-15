package com.pduleba.webapp.controller.web;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

import java.util.Optional;

@Controller
public class WebViewController {

    @GetMapping({"/{domain}", "/{domain}/index"})
    public String index(Model modal, @PathVariable("domain") final String domain) {
        modal.addAttribute("title", Optional.ofNullable(domain).orElse("Unknown").toUpperCase());
        return domain + "/index";
    }

    @GetMapping("/{domain}/partials/{page}")
    public String partials(@PathVariable("domain") final String domain, @PathVariable("page") final String page) {
        return domain + "/" + page;
    }

}
