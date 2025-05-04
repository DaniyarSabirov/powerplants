package de.thws.powerplants.core.services;

import de.thws.powerplants.adapters.out.persistence.entities.GroupEntity;
import de.thws.powerplants.adapters.out.persistence.entities.PlantEntity;
import de.thws.powerplants.adapters.out.persistence.repositories.GroupRepository;
import de.thws.powerplants.adapters.out.persistence.repositories.PlantRepository;
import de.thws.powerplants.core.domain.Plant;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.inject.Inject;
import jakarta.transaction.Transactional;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

@ApplicationScoped
public class PlantService {

    @Inject
    private GroupRepository groupRepository;

    @Inject
    private PlantRepository plantRepository;

    public PlantService() {}

    @Transactional
    public PlantEntity createPlant(UUID groupId, Plant plant) {

        GroupEntity group = groupRepository.findById(groupId);

        PlantEntity newPlant = new PlantEntity();

        newPlant.setPublicName(plant.getPublicName());
        newPlant.setScientificName(plant.getScientificName());
        newPlant.setDescription(plant.getDescription());
        newPlant.setPictureUrl(plant.getPictureUrl());

        newPlant.setGroup(group);

        plantRepository.persist(newPlant);

        return newPlant;
    }

    @Transactional
    public List<PlantEntity> getPlantsByGroup(UUID groupId) {
        return plantRepository.list("group.id", groupId);
    }

    @Transactional
    public boolean deletePlant(UUID groupId, UUID plantId) {

        GroupEntity group = groupRepository.findById(groupId);

        List<PlantEntity> plants = group.getPlants();

        PlantEntity plantEntity = plants.stream()
                .filter(plant -> plantId.equals(plant.getId()))
                .findFirst()
                .orElseThrow();

        plantEntity.setGroup(null);

        plants.remove(plantEntity);

        return true;
    }

    @Transactional
    public Optional<PlantEntity> getPlantById(UUID plantId) {
        return plantRepository.findByIdOptional(plantId);
    }

    @Transactional
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

    @Transactional
    public List<PlantEntity> getAllPlants() {
        return plantRepository.listAll();
    }
}
