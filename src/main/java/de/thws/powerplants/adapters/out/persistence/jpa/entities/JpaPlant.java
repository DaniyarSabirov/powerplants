package de.thws.powerplants.adapters.out.persistence.jpa.entities;

import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import jakarta.persistence.*;

@Entity
@Table(name = "plant")
public class JpaPlant {

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

    @Column(name = "image_id")
    private String imageId;

    @ManyToOne(cascade = CascadeType.ALL, optional = false)
    @JoinColumn(name = "home_group_id", nullable = false)
    private JpaGroup group;

    @OneToMany(mappedBy = "plant", cascade = CascadeType.ALL)
    private List<JpaPlantCareRule> plantCareRules = new ArrayList<>();

    @OneToMany(mappedBy = "plant", cascade = CascadeType.ALL)
    private List<JpaPlantCareDone> plantCareDones = new ArrayList<>();

    public JpaPlant() {}

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

    public String getImageId() {
        return imageId;
    }

    public void setImageId(String imageId) {
        this.imageId = imageId;
    }

    public JpaGroup getGroup() {
        return group;
    }

    public void setGroup(JpaGroup group) {
        this.group = group;
    }

    public List<JpaPlantCareRule> getPlantCareRules() {
        return plantCareRules;
    }

    public void setPlantCareRules(List<JpaPlantCareRule> plantCareRules) {
        this.plantCareRules = plantCareRules;
    }

    public List<JpaPlantCareDone> getPlantCareDones() {
        return plantCareDones;
    }

    public void setPlantCareDones(List<JpaPlantCareDone> plantCareDones) {
        this.plantCareDones = plantCareDones;
    }
}
