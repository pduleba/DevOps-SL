package com.pduleba.webapp.service;

import com.amazonaws.AmazonServiceException;
import com.amazonaws.HttpMethod;
import com.amazonaws.SdkClientException;
import com.amazonaws.http.HttpMethodName;
import com.amazonaws.services.s3.AmazonS3;
import com.amazonaws.services.s3.model.GeneratePresignedUrlRequest;
import com.pduleba.webapp.dto.s3.S3Request;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import java.time.Instant;
import java.util.Collections;
import java.util.Date;
import java.util.Optional;

import static com.pduleba.webapp.ApplicationConfig.AMAZON_S3_CLIENT;

@Slf4j
@Service
public class S3Service {

    private String bucketName;
    private Long expiry;
    private AmazonS3 s3Client;

    @Autowired
    public S3Service(@Value("${aws.signed.url.bucket}") String bucketName,
            @Value("${aws.signed.url.expiry}") Long expiry, @Qualifier(AMAZON_S3_CLIENT) AmazonS3 s3Client) {
        this.bucketName = bucketName;
        this.expiry = expiry;
        this.s3Client = s3Client;
    }

    public String getSignedUrl(S3Request s3request) {
        try {
            Date expiration = Date.from(Instant
                    .now()
                    .plusMillis(expiry));
            HttpMethod method = HttpMethod.valueOf(HttpMethodName
                    .fromValue(s3request.getHttpMethod())
                    .name());

            GeneratePresignedUrlRequest presignedUrlRequest = new GeneratePresignedUrlRequest(bucketName,
                    s3request.getFileName())
                    .withMethod(method)
                    .withExpiration(expiration);

            Optional
                    .ofNullable(s3request.getParams())
                    .orElse(Collections.emptyMap())
                    .forEach((k, v) -> presignedUrlRequest.addRequestParameter(k, v));

            return s3Client
                    .generatePresignedUrl(presignedUrlRequest)
                    .toString();
        } catch (AmazonServiceException e) {
            log.error("AmazonServiceException", e);
            throw e;
        } catch (SdkClientException e) {
            log.error("SdkClientException", e);
            throw e;
        }
    }
}
