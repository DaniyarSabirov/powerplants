package de.thws.powerplants.adapters.out.persistence.jpa.entities;

import jakarta.persistence.*;
import java.util.UUID;

@Entity
@Table(name = "plant_care_done")
public class JpaPlantCareDone {

    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    @Column(name = "id")
    private UUID id;

    @ManyToOne(cascade = CascadeType.ALL, optional = false)
    @JoinColumn(name = "plant_id", nullable = false)
    private JpaPlant plant;

    public JpaPlantCareDone() {}

    public UUID getId() {
        return id;
    }

    public void setId(UUID id) {
        this.id = id;
    }

    public JpaPlant getPlant() {
        return plant;
    }

    public void setPlant(JpaPlant plant) {
        this.plant = plant;
    }
}
