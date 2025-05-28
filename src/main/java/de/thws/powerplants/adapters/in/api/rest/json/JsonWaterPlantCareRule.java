package de.thws.powerplants.adapters.in.api.rest.json;

import com.fasterxml.jackson.databind.PropertyNamingStrategies;
import com.fasterxml.jackson.databind.annotation.JsonNaming;

@JsonNaming(PropertyNamingStrategies.SnakeCaseStrategy.class)
public class JsonWaterPlantCareRule extends JsonPlantCareRule {

    private Long amount;

    public JsonWaterPlantCareRule() {}

    public Long getAmount() {
        return amount;
    }

    public void setAmount(Long amount) {
        this.amount = amount;
    }
}
