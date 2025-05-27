package de.thws.powerplants.core.services;

import de.thws.powerplants.core.domain.Plant;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

public interface PlantService {

    Plant createPlant(UUID groupId, Plant plant);

    List<Plant> getPlants(UUID groupId);

    Optional<Plant> getPlantById(UUID groupId, UUID plantId);

    Plant updatePlantById(UUID groupId, UUID plantId, Plant plant);

    void deletePlantById(UUID groupId, UUID plantId);
}
