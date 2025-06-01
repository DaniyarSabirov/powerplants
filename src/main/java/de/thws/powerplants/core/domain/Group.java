package de.thws.powerplants.core.domain;

import java.util.List;
import java.util.UUID;

public class Group implements ImageHolder {

    private UUID id;
    private String publicName;
    private String description;
    private String imageId;

    private Home home;
    private List<Plant> plants;

    public Group() {}

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

    @Override
    public String getImageId() {
        return imageId;
    }

    @Override
    public void setImageId(String imageId) {
        this.imageId = imageId;
    }

    public Home getHome() {
        return home;
    }

    public void setHome(Home home) {
        this.home = home;
    }

    public List<Plant> getPlants() {
        return plants;
    }

    public void setPlants(List<Plant> plants) {
        this.plants = plants;
    }
}
