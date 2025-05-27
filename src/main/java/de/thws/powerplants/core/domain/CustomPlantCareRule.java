package de.thws.powerplants.core.domain;

public class CustomPlantCareRule extends PlantCareRule {

    private String customInstructions;

    public CustomPlantCareRule() {}

    public String getCustomInstructions() {
        return customInstructions;
    }

    public void setCustomInstructions(String customInstructions) {
        this.customInstructions = customInstructions;
    }
}
