package de.thws.powerplants.adapters.in.api.rest.json;

import com.fasterxml.jackson.databind.PropertyNamingStrategies;
import com.fasterxml.jackson.databind.annotation.JsonNaming;

@JsonNaming(PropertyNamingStrategies.SnakeCaseStrategy.class)
public class JsonCustomPlantCareRule extends JsonPlantCareRule {

    private String customInstructions;

    public JsonCustomPlantCareRule() {}

    public String getCustomInstructions() {
        return customInstructions;
    }

    public void setCustomInstructions(String customInstructions) {
        this.customInstructions = customInstructions;
    }
}
