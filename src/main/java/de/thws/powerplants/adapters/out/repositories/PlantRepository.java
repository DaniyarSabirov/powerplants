package de.thws.powerplants.adapters.out.repositories;

import de.thws.powerplants.adapters.out.entities.PlantEntity;
import io.quarkus.hibernate.orm.panache.PanacheRepository;
import jakarta.enterprise.context.ApplicationScoped;

@ApplicationScoped
public class PlantRepository implements PanacheRepository<PlantEntity> {}
