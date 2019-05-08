package com.pduleba.webapp.controller.rest;

import com.pduleba.webapp.dto.s3.S3Request;
import com.pduleba.webapp.dto.util.RestResponse;
import com.pduleba.webapp.mapper.hateoas.HateoasMapper;
import com.pduleba.webapp.service.S3Service;
import lombok.AllArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;

import static org.springframework.hateoas.mvc.ControllerLinkBuilder.methodOn;

@RestController
@AllArgsConstructor(onConstructor = @__(@Autowired))
@RequestMapping("/api/s3")
public class S3Controller {

    private static final S3Controller RESOURCE = methodOn(S3Controller.class);

    private S3Service s3Service;
    private HateoasMapper hateoasMapper;

    @PostMapping("/signedUrl")
    public RestResponse<String> getSignedUrl(@Valid @RequestBody S3Request s3request) {
        return hateoasMapper.toResource(s3Service.getSignedUrl(s3request), RESOURCE.getSignedUrl(s3request));
    }
}
