package de.thws.powerplants.core.domain;

import java.time.LocalDateTime;
import java.util.UUID;

public class PlantCareDone {

    private UUID id;
    private LocalDateTime completedAt;
    private String details;

    public PlantCareDone() {}

    public UUID getId() {
        return id;
    }

    public void setId(UUID id) {
        this.id = id;
    }

    public LocalDateTime getCompletedAt() {
        return completedAt;
    }

    public void setCompletedAt(LocalDateTime completedAt) {
        this.completedAt = completedAt;
    }

    public String getDetails() {
        return details;
    }

    public void setDetails(String details) {
        this.details = details;
    }
}
