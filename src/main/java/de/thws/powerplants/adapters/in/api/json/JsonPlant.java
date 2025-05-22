package de.thws.powerplants.adapters.in.api.json;

import com.fasterxml.jackson.databind.PropertyNamingStrategies;
import com.fasterxml.jackson.databind.annotation.JsonNaming;
import java.util.List;
import java.util.UUID;

@JsonNaming(PropertyNamingStrategies.SnakeCaseStrategy.class)
public class JsonPlant {

    private UUID id;
    private String publicName;
    private String scientificName;
    private String description;
    private String pictureUrl;
    private JsonPlantMetadata metadata;

    private List<? extends JsonPlantCareRule> plantCareRules;
    private List<JsonPlantCareDone> plantCareDones;

    public JsonPlant() {}

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

    public JsonPlantMetadata getMetadata() {
        return metadata;
    }

    public void setMetadata(JsonPlantMetadata metadata) {
        this.metadata = metadata;
    }

    public List<? extends JsonPlantCareRule> getPlantCareRules() {
        return plantCareRules;
    }

    public void setPlantCareRules(List<? extends JsonPlantCareRule> plantCareRules) {
        this.plantCareRules = plantCareRules;
    }

    public List<JsonPlantCareDone> getPlantCareDones() {
        return plantCareDones;
    }

    public void setPlantCareDones(List<JsonPlantCareDone> plantCareDones) {
        this.plantCareDones = plantCareDones;
    }
}
