package com.pduleba.webapp.mapper.hateoas;

import com.pduleba.webapp.dto.util.RestResponse;
import org.springframework.stereotype.Component;

import static org.springframework.hateoas.mvc.ControllerLinkBuilder.linkTo;

@Component
public class HateoasMapper {

    public <T> RestResponse<T> toResource(T content, RestResponse<T> method) {
        return new RestResponse<T>(content, linkTo(method).withSelfRel());
    }
}
