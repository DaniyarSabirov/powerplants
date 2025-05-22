package de.thws.powerplants.adapters.out.persistence.entities;

import jakarta.persistence.*;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

@Entity
@Table(name = "home_group")
public class JpaGroup {

    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    @Column(name = "id")
    private UUID id;

    @ManyToOne(cascade = CascadeType.ALL)
    @JoinColumn(name = "home_id")
    private JpaHome home;

    @OneToMany(mappedBy = "group", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<JpaPlant> plants = new ArrayList<>();

    @Column(name = "public_name", nullable = false)
    private String publicName;

    @Column(name = "description")
    private String description;

    @Column(name = "picture_url")
    private String pictureUrl;

    public JpaGroup() {}

    public UUID getId() {
        return id;
    }

    public void setId(UUID id) {
        this.id = id;
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

    public String getPictureUrl() {
        return pictureUrl;
    }

    public void setPictureUrl(String pictureUrl) {
        this.pictureUrl = pictureUrl;
    }
}
