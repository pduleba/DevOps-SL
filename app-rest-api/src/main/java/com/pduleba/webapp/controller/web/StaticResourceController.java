package com.pduleba.webapp.controller.web;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

@Controller
public class StaticResourceController {

    @GetMapping("/{domain}/css/{resource}")
    public String css(@PathVariable("resource") final String resource) {
        return "/css/" + resource;
    }

    @GetMapping("/{domain}/js/{sub}/{resource}")
    public String js(@PathVariable("sub") final String sub, @PathVariable("resource") final String resource) {
        return "/js/" + sub + "/" + resource;
    }

}
