package com.pduleba.webapp;

import com.amazonaws.auth.AWSCredentialsProvider;
import com.amazonaws.auth.InstanceProfileCredentialsProvider;
import com.amazonaws.auth.profile.ProfileCredentialsProvider;
import com.amazonaws.regions.Regions;
import com.amazonaws.services.s3.AmazonS3;
import com.amazonaws.services.s3.AmazonS3ClientBuilder;
import com.pduleba.webapp.dao.JpaRepositories;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Profile;
import org.springframework.context.annotation.PropertySource;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;

@Configuration
@PropertySource(factory = YamlPropertySourceFactory.class, value = {"classpath:aws.yml"})
@EnableJpaRepositories(basePackageClasses = {JpaRepositories.class})
public class ApplicationConfig {

    public final static String AMAZON_S3_CLIENT = "amazonS3Client";

    @Profile("local")
    @Bean
    public AWSCredentialsProvider localCredentialsProvider(@Value("${aws.profile:N/A}") String profileName) {
        return new ProfileCredentialsProvider(profileName);
    }

    @Profile("aws")
    @Bean
    public AWSCredentialsProvider awsCredentialsProvider() {
        return new InstanceProfileCredentialsProvider(false);
    }

    @Bean(AMAZON_S3_CLIENT)
    public AmazonS3 amazonS3Client(@Value("${aws.region:N/A}") String region,
            AWSCredentialsProvider awsCredentialsProvider) {
        return AmazonS3ClientBuilder
                .standard()
                .withRegion(Regions.fromName(region))
                .withCredentials(awsCredentialsProvider)
                .build();
    }


}
