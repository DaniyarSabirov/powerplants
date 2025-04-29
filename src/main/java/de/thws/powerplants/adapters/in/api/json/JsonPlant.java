package de.thws.powerplants.adapters.in.api.json;

import java.util.UUID;

public class JsonPlant {

    private UUID id;
    private UUID homeGroupId;
    private String publicName;
    private String scientificName;
    private String description;
    private String pictureUrl;

    public UUID getId() {
        return id;
    }

    public void setId(UUID id) {
        this.id = id;
    }

    public UUID getHomeGroupId() {
        return homeGroupId;
    }

    public void setHomeGroupId(UUID homeGroupId) {
        this.homeGroupId = homeGroupId;
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
}
