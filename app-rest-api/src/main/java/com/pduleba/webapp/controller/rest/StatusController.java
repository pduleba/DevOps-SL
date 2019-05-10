package com.pduleba.webapp.controller.rest;

import com.pduleba.webapp.dto.util.RestResponse;
import com.pduleba.webapp.mapper.hateoas.HateoasMapper;
import lombok.AllArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import static org.springframework.hateoas.mvc.ControllerLinkBuilder.methodOn;

@RestController
@AllArgsConstructor(onConstructor = @__(@Autowired))
@RequestMapping("/api/status")
public class StatusController {

    private static final StatusController RESOURCE = methodOn(StatusController.class);

    private HateoasMapper hateoasMapper;

    @GetMapping("/ping")
    public RestResponse<String> ping() {
        return hateoasMapper.toResource("pong", RESOURCE.ping());
    }

}
