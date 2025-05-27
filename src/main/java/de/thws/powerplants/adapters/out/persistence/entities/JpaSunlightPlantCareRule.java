package de.thws.powerplants.adapters.out.persistence.entities;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Table;

@Entity
@Table(name = "plant_care_rule_sunlight")
public class JpaSunlightPlantCareRule extends JpaPlantCareRule {

    @Column(name = "duration", nullable = false)
    private Long duration;

    public JpaSunlightPlantCareRule() {}

    public Long getDuration() {
        return duration;
    }

    public void setDuration(Long duration) {
        this.duration = duration;
    }
}
