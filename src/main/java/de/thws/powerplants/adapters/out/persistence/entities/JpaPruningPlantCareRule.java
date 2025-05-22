package de.thws.powerplants.adapters.out.persistence.entities;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Table;

@Entity
@Table(name = "plant_care_rule_pruning")
public class JpaPruningPlantCareRule extends JpaPlantCareRule {

    @Column(name = "amount", nullable = false)
    private String amount;

    public JpaPruningPlantCareRule() {}

    public String getAmount() {
        return amount;
    }

    public void setAmount(String amount) {
        this.amount = amount;
    }
}
