package de.thws.powerplants.adapters.in.api.rest.json;

import com.fasterxml.jackson.databind.PropertyNamingStrategies;
import com.fasterxml.jackson.databind.annotation.JsonNaming;

@JsonNaming(PropertyNamingStrategies.SnakeCaseStrategy.class)
public class JsonSunlightPlantCareRule extends JsonPlantCareRule {

    private Long duration;

    public JsonSunlightPlantCareRule() {}

    public Long getDuration() {
        return duration;
    }

    public void setDuration(Long duration) {
        this.duration = duration;
    }
}
