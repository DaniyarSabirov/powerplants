package de.thws.powerplants.adapters.out.persistence.entities;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Table;

@Entity
@Table(name = "plant_care_rule_custom")
public class CustomPlantCareRuleEntity extends PlantCareRuleEntity {

    @Column(name = "custom_instructions", nullable = false)
    private String customInstructions;

    public CustomPlantCareRuleEntity() {}

    public String getCustomInstructions() {
        return customInstructions;
    }

    public void setCustomInstructions(String customInstructions) {
        this.customInstructions = customInstructions;
    }
}
