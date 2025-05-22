package de.thws.powerplants.core.domain;

import java.util.UUID;

public class Plant {

    private UUID id;
    private String publicName;
    private String scientificName;
    private String description;
    private String pictureUrl;
    private PlantMetadata metadata;

    public Plant() {}

    public UUID getId() {
        return id;
    }

    public void setId(UUID id) {
        this.id = id;
    }

    public String getPublicName() {
        return publicName;
    }

    public void setPublicName(String publicName) {
        this.publicName = publicName;
    }

    public String getScientificName() {
        return scientificName;
    }

    public void setScientificName(String scientificName) {
        this.scientificName = scientificName;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getPictureUrl() {
        return pictureUrl;
    }

    public void setPictureUrl(String pictureUrl) {
        this.pictureUrl = pictureUrl;
    }

    public PlantMetadata getMetadata() {
        return metadata;
    }

    public void setMetadata(PlantMetadata metadata) {
        this.metadata = metadata;
    }
}
