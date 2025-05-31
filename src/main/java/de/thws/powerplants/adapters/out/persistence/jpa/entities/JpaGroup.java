package de.thws.powerplants.adapters.out.persistence.jpa.entities;

import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import jakarta.persistence.*;

@Entity
@Table(name = "home_group")
public class JpaGroup {

    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    @Column(name = "id")
    private UUID id;

    @Column(name = "public_name", nullable = false)
    private String publicName;

    @Column(name = "description")
    private String description;

    @Column(name = "image_id")
    private String imageId;

    @ManyToOne(cascade = CascadeType.ALL, optional = false)
    @JoinColumn(name = "home_id", nullable = false)
    private JpaHome home;

    @OneToMany(mappedBy = "group", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<JpaPlant> plants = new ArrayList<>();

    public JpaGroup() {}

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

    public JpaHome getHome() {
        return home;
    }

    public void setHome(JpaHome home) {
        this.home = home;
    }

    public List<JpaPlant> getPlants() {
        return plants;
    }

    public void setPlants(List<JpaPlant> plants) {
        this.plants = plants;
    }
}
