package de.thws.powerplants.adapters.out.entities;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Table;

@Entity
@Table(name = "plant_care_rule_custom")
public class CustomPlantCareRuleEntity extends PlantCareRuleEntity {

    @Column(name = "instructions", nullable = false)
    private String instructions;

    public CustomPlantCareRuleEntity() {}

    @Override
    public String getInstructions() {
        return instructions;
    }

    @Override
    public void setInstructions(String instructions) {
        this.instructions = instructions;
    }
}
