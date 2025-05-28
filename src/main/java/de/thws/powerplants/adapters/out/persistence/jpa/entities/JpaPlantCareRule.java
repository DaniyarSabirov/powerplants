package de.thws.powerplants.adapters.out.persistence.jpa.entities;

import java.util.UUID;

import jakarta.persistence.*;

@Entity
@Table(name = "plant_care_rule")
@Inheritance(strategy = InheritanceType.JOINED)
public abstract class JpaPlantCareRule {

    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    @Column(name = "id")
    private UUID id;

    @Column(name = "public_name", nullable = false)
    private String name;

    @Column(name = "enabled", nullable = false)
    private boolean enabled;

    @Column(name = "cron", nullable = false)
    private String cron;

    @Column(name = "instructions")
    private String instructions;

    @ManyToOne(cascade = CascadeType.ALL, optional = false)
    @JoinColumn(name = "plant_id", nullable = false)
    private JpaPlant plant;

    public JpaPlantCareRule() {}

    public UUID getId() {
        return id;
    }

    public void setId(UUID id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public boolean isEnabled() {
        return enabled;
    }

    public void setEnabled(boolean enabled) {
        this.enabled = enabled;
    }

    public String getCron() {
        return cron;
    }

    public void setCron(String cron) {
        this.cron = cron;
    }

    public String getInstructions() {
        return instructions;
    }

    public void setInstructions(String instructions) {
        this.instructions = instructions;
    }

    public JpaPlant getPlant() {
        return plant;
    }

    public void setPlant(JpaPlant plant) {
        this.plant = plant;
    }
}
