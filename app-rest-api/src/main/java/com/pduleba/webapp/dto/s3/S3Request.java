package com.pduleba.webapp.dto.s3;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.NotNull;
import java.util.HashMap;
import java.util.Map;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class S3Request {

    @NotEmpty(message = "httpMethod is required")
    private String httpMethod;
    @NotEmpty(message = "httpMethod is required")
    private String fileName;
    @NotNull(message = "httpMethod is required")
    private Map<String, String> params = new HashMap<>();
}
