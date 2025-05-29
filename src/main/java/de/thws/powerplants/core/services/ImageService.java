package de.thws.powerplants.core.services;

import java.io.InputStream;
import java.util.UUID;

import de.thws.powerplants.core.domain.ImageHolder;

public interface ImageService {

    void createImage(UUID imageId, InputStream inputStream);

    InputStream getImageById(UUID imageId);

    void deleteImageById(UUID imageId);

    default UUID storeImageInHolder(ImageHolder imageHolder, InputStream image) {

        if (imageHolder == null || image == null) {
            throw new NullPointerException();
        }

        String oldImageId = imageHolder.getImageId();
        if (oldImageId != null) {
            deleteImageById(UUID.fromString(oldImageId));
            imageHolder.setImageId(null);
        }

        UUID imageId = UUID.randomUUID();

        createImage(imageId, image);
        imageHolder.setImageId(imageId.toString());

        return imageId;
    }
}
