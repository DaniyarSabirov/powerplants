package de.thws.powerplants.adapters.in.api.rest.service;

import de.thws.powerplants.core.ports.in.ImageServicePortIn;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.inject.Inject;
import java.io.InputStream;
import java.util.UUID;

@ApplicationScoped
public class RestImageService {

    @Inject
    private ImageServicePortIn imageServicePortIn;

    public RestImageService() {}

    public void createImage(UUID imageId, InputStream inputStream) {
        imageServicePortIn.createImage(imageId, inputStream);
    }

    public InputStream getImageById(UUID imageId) {
        return imageServicePortIn.getImageById(imageId);
    }
}
