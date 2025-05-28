package de.thws.powerplants.adapters.in.api.rest.json;

import com.fasterxml.jackson.databind.PropertyNamingStrategies;
import com.fasterxml.jackson.databind.annotation.JsonNaming;

@JsonNaming(PropertyNamingStrategies.SnakeCaseStrategy.class)
public class JsonPruningPlantCareRule extends JsonPlantCareRule {

    public enum Amount {
        LESS,
        MORE,
        MUCH
    }

    private Amount amount;

    public JsonPruningPlantCareRule() {}

    public Amount getAmount() {
        return amount;
    }

    public void setAmount(Amount amount) {
        this.amount = amount;
    }
}
