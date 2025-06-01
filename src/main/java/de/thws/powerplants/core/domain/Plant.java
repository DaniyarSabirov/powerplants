package de.thws.powerplants.core.domain;

import java.util.List;
import java.util.UUID;

public class Plant implements ImageHolder {

    private UUID id;
    private String publicName;
    private String scientificName;
    private String description;
    private String imageId;
    private PlantMetadata metadata;

    private Group group;
    private List<? extends PlantCareRule> plantCareRules;
    private List<PlantCareDone> plantCareDones;

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

    @Override
    public String getImageId() {
        return imageId;
    }

    @Override
    public void setImageId(String imageId) {
        this.imageId = imageId;
    }

    public PlantMetadata getMetadata() {
        return metadata;
    }

    public void setMetadata(PlantMetadata metadata) {
        this.metadata = metadata;
    }

    public Group getGroup() {
        return group;
    }

    public void setGroup(Group group) {
        this.group = group;
    }

    public List<? extends PlantCareRule> getPlantCareRules() {
        return plantCareRules;
    }

    public void setPlantCareRules(List<? extends PlantCareRule> plantCareRules) {
        this.plantCareRules = plantCareRules;
    }

    public List<PlantCareDone> getPlantCareDones() {
        return plantCareDones;
    }

    public void setPlantCareDones(List<PlantCareDone> plantCareDones) {
        this.plantCareDones = plantCareDones;
    }
}
