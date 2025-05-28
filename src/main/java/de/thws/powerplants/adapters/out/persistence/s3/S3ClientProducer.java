package de.thws.powerplants.adapters.out.persistence.s3;

import java.net.URI;

import jakarta.enterprise.context.ApplicationScoped;
import jakarta.enterprise.inject.Produces;

import org.eclipse.microprofile.config.inject.ConfigProperty;
import software.amazon.awssdk.auth.credentials.AwsBasicCredentials;
import software.amazon.awssdk.auth.credentials.StaticCredentialsProvider;
import software.amazon.awssdk.regions.Region;
import software.amazon.awssdk.services.s3.S3Client;
import software.amazon.awssdk.services.s3.S3Configuration;

@ApplicationScoped
public class S3ClientProducer {

    @ConfigProperty(name = "s3.endpoint")
    private String endpoint;

    @ConfigProperty(name = "s3.access-key-id")
    private String accessKeyId;

    @ConfigProperty(name = "s3.secret-access-key")
    private String secretAccessKey;

    public S3ClientProducer() {}

    @Produces
    public S3Client buildS3Client() {
        return S3Client.builder()
                .endpointOverride(URI.create(endpoint))
                .region(Region.EU_CENTRAL_1)
                .credentialsProvider(
                        StaticCredentialsProvider.create(AwsBasicCredentials.create(accessKeyId, secretAccessKey)))
                .serviceConfiguration(
                        S3Configuration.builder().pathStyleAccessEnabled(true).build())
                .build();
    }
}
