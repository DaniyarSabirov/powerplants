package de.thws.powerplants.core.services;

import java.io.InputStream;
import java.util.UUID;

import jakarta.enterprise.context.ApplicationScoped;
import jakarta.inject.Inject;

import de.thws.powerplants.core.ports.in.ImageServicePortIn;
import de.thws.powerplants.core.ports.out.ImageServicePortOut;

@ApplicationScoped
public class DefaultImageService implements ImageServicePortIn {

    @Inject
    private ImageServicePortOut imageServicePortOut;

    public DefaultImageService() {}

    @Override
    public void createImage(UUID imageId, InputStream inputStream) {
        imageServicePortOut.createImage(imageId, inputStream);
    }

    @Override
    public InputStream getImageById(UUID imageId) {
        return imageServicePortOut.getImageById(imageId);
    }
}
