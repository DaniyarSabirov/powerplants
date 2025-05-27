package de.thws.powerplants.adapters.out.persistence.service;

import de.thws.powerplants.adapters.out.persistence.entities.JpaGroup;
import de.thws.powerplants.adapters.out.persistence.entities.JpaPlant;
import de.thws.powerplants.adapters.out.persistence.repositories.JpaGroupRepository;
import de.thws.powerplants.adapters.out.persistence.repositories.JpaPlantRepository;
import de.thws.powerplants.core.domain.Plant;
import de.thws.powerplants.core.ports.out.PlantServicePortOut;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.inject.Inject;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

@ApplicationScoped
public class JpaPlantService implements PlantServicePortOut {

    @Inject
    private JpaGroupRepository jpaGroupRepository;

    @Inject
    private JpaPlantRepository jpaPlantRepository;

    @Inject
    private JpaMapper jpaMapper;

    public JpaPlantService() {}

    protected JpaPlant copyPlant(JpaPlant jpaPlant, Plant plant) {

        // jpaPlant.setId(plant.getId());
        jpaPlant.setScientificName(plant.getScientificName());
        jpaPlant.setPublicName(plant.getPublicName());
        jpaPlant.setDescription(plant.getDescription());
        jpaPlant.setPictureUrl(plant.getPictureUrl());

        return jpaPlant;
    }

    @Override
    public Plant createPlant(UUID groupId, Plant plant) {

        JpaGroup group = jpaGroupRepository.findById(groupId);
        if (group == null) {
            throw new NullPointerException(); // todo
        }

        JpaPlant jpaPlant = jpaMapper.toJpaPlant(plant);

        jpaPlant.setGroup(group);

        jpaPlantRepository.persist(jpaPlant);

        return jpaMapper.toPlant(jpaPlant);
    }

    @Override
    public List<Plant> getPlants(UUID groupId) {

        JpaGroup group = jpaGroupRepository.findById(groupId);
        if (group == null) {
            throw new NullPointerException(); // todo
        }

        return group.getPlants().stream().map(jpaMapper::toPlant).toList();
    }

    @Override
    public Optional<Plant> getPlantById(UUID groupId, UUID plantId) {

        Optional<JpaPlant> plant = jpaPlantRepository.findByIdOptional(plantId);

        return plant.map(jpaMapper::toPlant);
    }

    @Override
    public Plant updatePlantById(UUID groupId, UUID plantId, Plant plant) {

        return jpaPlantRepository
                .findByIdOptional(plantId)
                .map((v) -> copyPlant(v, plant))
                .map(jpaMapper::toPlant)
                .orElseThrow();
    }

    @Override
    public void deletePlantById(UUID groupId, UUID plantId) {
        jpaPlantRepository.deleteById(plantId);
    }
}
