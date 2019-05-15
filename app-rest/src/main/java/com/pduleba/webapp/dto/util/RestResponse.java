package com.pduleba.webapp.dto.util;

import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;
import org.springframework.hateoas.Link;
import org.springframework.hateoas.ResourceSupport;

import java.util.Objects;

@Data
@EqualsAndHashCode(callSuper = true)
@NoArgsConstructor
public class RestResponse<T> extends ResourceSupport {

    private T body;

    public RestResponse(T body) {
        this(body, null);
    }

    public RestResponse(T body, Link link) {
        this.body = body;
        if (Objects.nonNull(link)) {
            this.add(link);
        }
    }
}
