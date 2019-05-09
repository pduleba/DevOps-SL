package com.pduleba.webapp.service;

import com.amazonaws.AmazonServiceException;
import com.amazonaws.HttpMethod;
import com.amazonaws.SdkClientException;
import com.amazonaws.http.HttpMethodName;
import com.amazonaws.services.s3.AmazonS3;
import com.amazonaws.services.s3.model.DeleteObjectRequest;
import com.amazonaws.services.s3.model.GeneratePresignedUrlRequest;
import com.amazonaws.services.s3.model.ListObjectsV2Request;
import com.amazonaws.services.s3.model.ListObjectsV2Result;
import com.pduleba.webapp.dto.s3.S3Object;
import com.pduleba.webapp.dto.s3.S3Request;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import java.time.Instant;
import java.util.*;
import java.util.concurrent.atomic.AtomicBoolean;
import java.util.stream.Stream;

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
                    s3request.getKey())
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

    public List<S3Object> findAll() {
        final LinkedList<S3Object> objects = new LinkedList<>();

        try {

            // maxKeys is set to 2 to demonstrate the use of
            // ListObjectsV2Result.getNextContinuationToken()
            ListObjectsV2Request request = new ListObjectsV2Request()
                    .withBucketName(bucketName)
                    .withMaxKeys(10);
            ListObjectsV2Result result = null;

            do {
                result = s3Client.listObjectsV2(request);

                result
                        .getObjectSummaries()
                        .forEach((s3) -> objects.add(S3Object
                                .builder()
                                .key(s3.getKey())
                                .lastModified(s3.getLastModified())
                                .size(s3.getSize())
                                .build()));

                // If there are more than maxKeys keys in the bucket, get a continuation token
                // and list the next objects.
                String token = result.getNextContinuationToken();
                log.info("Next Continuation Token: {}", token);
                result.setContinuationToken(token);
            } while (result.isTruncated());

        } catch (AmazonServiceException e) {
            log.error("AmazonServiceException", e);
        } catch (SdkClientException e) {
            log.error("SdkClientException", e);
        }

        return objects;
    }

    public Optional<S3Object> delete(String key) {
        final AtomicBoolean complete = new AtomicBoolean(false);
        try {
            Optional<String> optionalKey = Optional.ofNullable(key);
            if (optionalKey.isPresent()) {
                Stream
                        .of(key)
                        .filter((k) -> s3Client.doesObjectExist(bucketName, key))
                        .forEach((k) -> {
                            s3Client.deleteObject(new DeleteObjectRequest(bucketName, key));
                            complete.set(Boolean.TRUE);
                        });
            }
        } catch (AmazonServiceException e) {
            log.error("AmazonServiceException", e);
        } catch (SdkClientException e) {
            log.error("SdkClientException", e);
        }
        return Optional.ofNullable(complete.get() ? S3Object
                .builder()
                .key(key)
                .lastModified(Date.from(Instant.now()))
                .size(0L)
                .build() : null);
    }
}
