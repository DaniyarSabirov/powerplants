package de.thws.powerplants.core.domain;

public class PruningPlantCareRule extends PlantCareRule {

    public enum Amount {
        LESS,
        MORE,
        MUCH
    }

    private Amount amount;

    public PruningPlantCareRule() {}

    public Amount getAmount() {
        return amount;
    }

    public void setAmount(Amount amount) {
        this.amount = amount;
    }
}
