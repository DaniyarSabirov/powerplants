package de.thws.powerplants.core.domain;

public class SunlightPlantCareRule extends PlantCareRule {

    private Long duration;

    public SunlightPlantCareRule() {}

    public Long getDuration() {
        return duration;
    }

    public void setDuration(Long duration) {
        this.duration = duration;
    }
}
