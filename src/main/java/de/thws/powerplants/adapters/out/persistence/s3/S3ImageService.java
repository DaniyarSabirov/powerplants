package de.thws.powerplants.adapters.out.persistence.s3;

import java.io.IOException;
import java.io.InputStream;
import java.util.UUID;

import jakarta.enterprise.context.ApplicationScoped;
import jakarta.inject.Inject;

import de.thws.powerplants.core.ports.out.ImageServicePortOut;
import software.amazon.awssdk.core.sync.RequestBody;
import software.amazon.awssdk.services.s3.S3Client;
import software.amazon.awssdk.services.s3.model.GetObjectRequest;
import software.amazon.awssdk.services.s3.model.PutObjectRequest;

@ApplicationScoped
public class S3ImageService implements ImageServicePortOut {

    public static final String BUCKET_NAME = "images";

    @Inject
    private S3Client s3Client;

    public S3ImageService() {}

    protected void checkBucket() {
        if (s3Client.listBuckets().buckets().stream().noneMatch(b -> BUCKET_NAME.equals(b.name()))) {
            s3Client.createBucket(b -> b.bucket(BUCKET_NAME));
        }
    }

    @Override
    public void createImage(UUID imageId, InputStream inputStream) {

        checkBucket();

        PutObjectRequest request = PutObjectRequest.builder()
                .bucket(BUCKET_NAME)
                .key(imageId.toString())
                .build();

        try {
            byte[] data = inputStream.readAllBytes();

            s3Client.putObject(request, RequestBody.fromBytes(data));

        } catch (IOException e) {
            throw new IllegalStateException("cannot read input stream", e);
        }
    }

    @Override
    public InputStream getImageById(UUID imageId) {

        checkBucket();

        GetObjectRequest request = GetObjectRequest.builder()
                .bucket(BUCKET_NAME)
                .key(imageId.toString())
                .build();

        return s3Client.getObject(request);
    }
}
