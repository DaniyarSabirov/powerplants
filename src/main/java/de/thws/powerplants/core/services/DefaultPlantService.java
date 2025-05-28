package de.thws.powerplants.core.services;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

import jakarta.enterprise.context.ApplicationScoped;
import jakarta.inject.Inject;

import de.thws.powerplants.core.domain.Plant;
import de.thws.powerplants.core.ports.in.PlantServicePortIn;
import de.thws.powerplants.core.ports.out.PlantServicePortOut;

@ApplicationScoped
public class DefaultPlantService implements PlantServicePortIn {

    @Inject
    private PlantServicePortOut plantServicePortOut;

    public DefaultPlantService() {}

    @Override
    public Plant createPlant(UUID groupId, Plant plant) {
        return plantServicePortOut.createPlant(groupId, plant);
    }

    @Override
    public List<Plant> getPlants(UUID groupId) {
        return plantServicePortOut.getPlants(groupId);
    }

    @Override
    public Optional<Plant> getPlantById(UUID groupId, UUID plantId) {
        return plantServicePortOut.getPlantById(groupId, plantId);
    }

    @Override
    public Plant updatePlantById(UUID groupId, UUID plantId, Plant plant) {
        return plantServicePortOut.updatePlantById(groupId, plantId, plant);
    }

    @Override
    public void deletePlantById(UUID groupId, UUID plantId) {
        plantServicePortOut.deletePlantById(groupId, plantId);
    }
}
