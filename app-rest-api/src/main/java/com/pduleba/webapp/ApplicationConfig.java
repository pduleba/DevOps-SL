package com.pduleba.webapp;

import com.amazonaws.auth.profile.ProfileCredentialsProvider;
import com.amazonaws.services.s3.AmazonS3;
import com.amazonaws.services.s3.AmazonS3ClientBuilder;
import com.pduleba.webapp.dao.JpaRepositories;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.PropertySource;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;

@Configuration
@PropertySource(factory = YamlPropertySourceFactory.class, value = {"classpath:aws.yml"})
@EnableJpaRepositories(basePackageClasses = {JpaRepositories.class})
public class ApplicationConfig {

    public final static String AMAZON_S3_CLIENT = "amazonS3Client";

    @Bean(AMAZON_S3_CLIENT)
    public AmazonS3 getAmazonS3Client(@Value("${aws.signed.url.profile:N/A}") String profileName,
                                      @Value("${aws.signed.url.region:N/A}") String region) {
        return AmazonS3ClientBuilder
                .standard()
                .withRegion(region)
                .withCredentials(new ProfileCredentialsProvider(profileName))
                .build();
    }


}
