package de.thws.powerplants.core.services;

import de.thws.powerplants.adapters.out.entities.PlantEntity;
import de.thws.powerplants.adapters.out.repositories.PlantRepository;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.inject.Inject;
import java.util.List;

@ApplicationScoped
public class PlantService {

    @Inject
    private PlantRepository plantRepository;

    public PlantService() {}

    public List<PlantEntity> getAll() {
        return plantRepository.listAll();
    }
}
