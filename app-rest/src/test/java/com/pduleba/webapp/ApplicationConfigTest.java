package com.pduleba.webapp;

import com.amazonaws.auth.AWSCredentialsProvider;
import com.amazonaws.auth.AWSStaticCredentialsProvider;
import com.amazonaws.auth.AnonymousAWSCredentials;
import com.pduleba.webapp.mapper.hateoas.HateoasMapper;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Profile;

@Profile("test")
@Configuration
public class ApplicationConfigTest {

    @Bean
    public AWSCredentialsProvider testCredentialsProvider() {
        return new AWSStaticCredentialsProvider(new AnonymousAWSCredentials());
    }

    @Bean
    public HateoasMapper testHateoasMapper() {
        return new HateoasMapper();
    }

}
