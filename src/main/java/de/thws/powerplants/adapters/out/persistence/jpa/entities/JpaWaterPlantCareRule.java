package de.thws.powerplants.adapters.out.persistence.jpa.entities;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Table;

@Entity
@Table(name = "plant_care_rule_water")
public class JpaWaterPlantCareRule extends JpaPlantCareRule {

    @Column(name = "amount", nullable = false)
    private Long amount;

    public JpaWaterPlantCareRule() {}

    public Long getAmount() {
        return amount;
    }

    public void setAmount(Long amount) {
        this.amount = amount;
    }
}
