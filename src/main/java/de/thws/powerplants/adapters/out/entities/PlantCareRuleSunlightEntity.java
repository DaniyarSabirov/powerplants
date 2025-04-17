package de.thws.powerplants.adapters.out.entities;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Table;

@Entity
@Table(name = "plant_care_rule_sunlight")
public class PlantCareRuleSunlightEntity extends PlantCareRuleEntity {

    @Column(name = "duration", nullable = false)
    private Long duration;

    public Long getDuration() {
        return duration;
    }

    public void setDuration(Long duration) {
        this.duration = duration;
    }
}
