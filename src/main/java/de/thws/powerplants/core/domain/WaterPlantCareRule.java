package de.thws.powerplants.core.domain;

public class WaterPlantCareRule extends PlantCareRule {

    private Long amount;

    public WaterPlantCareRule() {}

    public Long getAmount() {
        return amount;
    }

    public void setAmount(Long amount) {
        this.amount = amount;
    }
}
