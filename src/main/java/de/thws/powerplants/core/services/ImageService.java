package de.thws.powerplants.core.services;

import java.io.InputStream;
import java.util.UUID;

public interface ImageService {

    InputStream getImageById(UUID imageId);
}
