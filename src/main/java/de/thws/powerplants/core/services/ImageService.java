package de.thws.powerplants.core.services;

import java.io.InputStream;
import java.util.UUID;

public interface ImageService {

    void createImage(UUID imageId, InputStream inputStream);

    InputStream getImageById(UUID imageId);

    void deleteImageById(UUID imageId);
}
