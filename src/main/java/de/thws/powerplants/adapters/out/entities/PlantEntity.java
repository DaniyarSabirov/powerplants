package de.thws.powerplants.adapters.out.entities;

import jakarta.persistence.*;
import java.util.UUID;

@Entity
@Table(name = "plant")
public class PlantEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    @Column(name = "id")
    private UUID id;

    @Column(name = "public_name", nullable = false)
    private String publicName;

    @Column(name = "scientific_name", nullable = false)
    private String scientificName;

    @Column(name = "description")
    private String description;

    @Column(name = "picture_url")
    private String pictureUrl;

    // todo group foreign key

    public PlantEntity() {}

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
}
