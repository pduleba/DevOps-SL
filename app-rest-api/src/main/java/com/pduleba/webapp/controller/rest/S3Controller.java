package com.pduleba.webapp.controller.rest;

import com.pduleba.webapp.dto.s3.S3Object;
import com.pduleba.webapp.dto.s3.S3Request;
import com.pduleba.webapp.dto.util.RestResponse;
import com.pduleba.webapp.mapper.hateoas.HateoasMapper;
import com.pduleba.webapp.service.S3Service;
import lombok.AllArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.List;
import java.util.Optional;

import static org.springframework.hateoas.mvc.ControllerLinkBuilder.methodOn;

@RestController
@AllArgsConstructor(onConstructor = @__(@Autowired))
@RequestMapping("/api/s3")
public class S3Controller {

    private static final S3Controller RESOURCE = methodOn(S3Controller.class);

    private S3Service s3Service;
    private HateoasMapper hateoasMapper;

    @GetMapping("/findAll")
    public RestResponse<List<S3Object>> findAll() {
        List<S3Object> s3Objects = s3Service.findAll();
        return hateoasMapper.toResource(s3Objects, RESOURCE.findAll());
    }

    @DeleteMapping("/delete/{key}")
    public RestResponse<S3Object> delete(@PathVariable("key") String key) {
        Optional<S3Object> s3Object = s3Service.delete(key);
        return hateoasMapper.toResource(s3Object.orElse(null), RESOURCE.delete(key));
    }

    @PostMapping("/signedUrl")
    public RestResponse<String> getSignedUrl(@Valid @RequestBody S3Request s3request) {
        return hateoasMapper.toResource(s3Service.getSignedUrl(s3request), RESOURCE.getSignedUrl(s3request));
    }
}
