package de.thws.powerplants.adapters.in.api.rest.service;

import de.thws.powerplants.adapters.in.api.rest.json.JsonMapper;
import de.thws.powerplants.adapters.in.api.rest.json.JsonPlant;
import de.thws.powerplants.core.domain.Plant;
import de.thws.powerplants.core.ports.in.PlantServicePortIn;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.inject.Inject;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

@ApplicationScoped
public class RestPlantService {

    @Inject
    private PlantServicePortIn plantServicePortIn;

    @Inject
    private JsonMapper jsonMapper;

    public RestPlantService() {}

    public JsonPlant createPlant(UUID groupId, JsonPlant jsonPlant) {

        Plant plant = jsonMapper.toPlant(jsonPlant);

        Plant result = plantServicePortIn.createPlant(groupId, plant);

        return jsonMapper.toJsonPlant(result);
    }

    public List<JsonPlant> getPlants(UUID groupId) {

        List<Plant> plants = plantServicePortIn.getPlants(groupId);

        return plants.stream().map(jsonMapper::toJsonPlant).toList();
    }

    public Optional<JsonPlant> getPlantById(UUID groupId, UUID plantId) {

        Optional<Plant> plant = plantServicePortIn.getPlantById(groupId, plantId);

        return plant.map(jsonMapper::toJsonPlant);
    }

    public JsonPlant updatePlantById(UUID groupId, UUID plantId, JsonPlant jsonPlant) {

        Plant plant = jsonMapper.toPlant(jsonPlant);

        Plant result = plantServicePortIn.updatePlantById(groupId, plantId, plant);

        return jsonMapper.toJsonPlant(result);
    }

    public void deletePlantById(UUID groupId, UUID plantId) {
        plantServicePortIn.deletePlantById(groupId, plantId);
    }
}
