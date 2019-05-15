package com.pduleba.webapp.controller.rest;

import com.pduleba.webapp.dto.util.RestResponse;
import com.pduleba.webapp.mapper.hateoas.HateoasMapper;
import lombok.AllArgsConstructor;
import org.springframework.web.bind.annotation.GetMapping;

@AllArgsConstructor
public abstract class AbstractController<T extends AbstractController> {

    protected final T resource;
    protected final HateoasMapper hateoasMapper;

    @GetMapping("/ping")
    public RestResponse<String> ping() {
        return hateoasMapper.toResource("pong", resource.ping());
    }

}
