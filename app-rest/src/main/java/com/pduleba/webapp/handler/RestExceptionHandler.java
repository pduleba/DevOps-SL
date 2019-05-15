package com.pduleba.webapp.handler;

import com.pduleba.webapp.dto.util.ErrorResponse;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.context.request.WebRequest;
import org.springframework.web.servlet.mvc.method.annotation.ResponseEntityExceptionHandler;

import java.util.stream.Collectors;

import static org.springframework.http.HttpStatus.INTERNAL_SERVER_ERROR;
import static org.springframework.http.HttpStatus.BAD_REQUEST;

@Slf4j
@ControllerAdvice
public class RestExceptionHandler extends ResponseEntityExceptionHandler {

    @ExceptionHandler({Exception.class})
    protected ResponseEntity<Object> handleExceptionInternal(Exception ex, HttpStatus status, WebRequest request) {
        log.error("Exception detected", ex);
        return handleExceptionInternal(ex, getBody(ex, status), new HttpHeaders(), status, request);
    }

    @Override
    protected ResponseEntity<Object> handleMethodArgumentNotValid(MethodArgumentNotValidException ex,
                                                                  HttpHeaders headers, HttpStatus status, WebRequest request) {
        return super.handleExceptionInternal(ex, getBody(ex, status), headers, status, request);
    }

    private ErrorResponse getBody(Exception ex, HttpStatus status) {
        return ErrorResponse.builder()
                .code(status.value())
                .codeReason(status.getReasonPhrase())
                .error(ex.getMessage())
                .build();
    }

    private ErrorResponse getBody(MethodArgumentNotValidException ex, HttpStatus status) {
        return ErrorResponse.builder()
                .code(status.value())
                .codeReason(status.getReasonPhrase())
                .errors(ex.getBindingResult()
                        .getFieldErrors()
                        .stream()
                        .map(x -> x.getDefaultMessage())
                        .collect(Collectors.toList()))
                .build();
    }

}
