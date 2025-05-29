package de.thws.powerplants.adapters.in.api.rest.json;

import java.util.List;
import java.util.UUID;

import com.fasterxml.jackson.databind.PropertyNamingStrategies;
import com.fasterxml.jackson.databind.annotation.JsonNaming;

@JsonNaming(PropertyNamingStrategies.SnakeCaseStrategy.class)
public class JsonGroup {

    private UUID id;
    private String publicName;
    private String description;
    private String imageId;

    private List<JsonPlant> plants;

    public JsonGroup() {}

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

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getImageId() {
        return imageId;
    }

    public void setImageId(String imageId) {
        this.imageId = imageId;
    }

    public List<JsonPlant> getPlants() {
        return plants;
    }

    public void setPlants(List<JsonPlant> plants) {
        this.plants = plants;
    }
}
