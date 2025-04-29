package de.thws.powerplants.core.services;

import de.thws.powerplants.adapters.out.persistence.entities.PlantEntity;
import de.thws.powerplants.adapters.out.persistence.repositories.PlantRepository;
import de.thws.powerplants.core.domain.Plant;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.inject.Inject;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

@ApplicationScoped
public class PlantService {

    @Inject
    private PlantRepository plantRepository;

    public PlantService() {}

    public PlantEntity createPlant(Plant plant) {
        PlantEntity newPlant = new PlantEntity();
        newPlant.setPublicName(plant.getPublicName());
        newPlant.setScientificName(plant.getScientificName());
        newPlant.setDescription(plant.getDescription());
        newPlant.setPictureUrl(plant.getPictureUrl());

        plantRepository.persist(newPlant);

        return newPlant;
    }

    public List<PlantEntity> getPlantsByGroup(UUID groupId) {
        return plantRepository.list("group.id", groupId);
    }

    public boolean deletePlant(UUID plantId) {
        return plantRepository.deleteById(plantId);
    }

    public Optional<PlantEntity> getPlantById(UUID plantId) {
        return plantRepository.findByIdOptional(plantId);
    }

    public Optional<PlantEntity> updatePlant(UUID plantId, Plant request) {
        Optional<PlantEntity> plantOpt = plantRepository.findByIdOptional(plantId);
        if (plantOpt.isEmpty()) {
            return Optional.empty();
        }

        PlantEntity plant = plantOpt.get();
        plant.setPublicName(request.getPublicName());
        plant.setScientificName(request.getScientificName());
        plant.setDescription(request.getDescription());
        plant.setPictureUrl(request.getPictureUrl());

        plantRepository.persist(plant);

        return Optional.of(plant);
    }

    public List<PlantEntity> getAllPlants() {
        return plantRepository.listAll();
    }
}
