package com.pduleba.webapp.dto.util;

import lombok.Builder;
import lombok.Data;

import java.util.Collection;
import java.util.LinkedList;
import java.util.List;

@Data
@Builder
public class ErrorResponse {

    private int code;
    private String codeReason;
    @Builder.Default
    private List<String> errors = new LinkedList<>();

    public static class ErrorResponseBuilder {

        public ErrorResponseBuilder error(String error) {
            this.errors.add(error);
            return this;
        }

        public ErrorResponseBuilder errors(Collection<String> errors) {
            this.errors.addAll(errors);
            return this;
        }
    }
}
