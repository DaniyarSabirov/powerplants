package de.thws.powerplants.adapters.out.repositories;

import de.thws.powerplants.adapters.out.entities.PlantCareRuleEntity;
import io.quarkus.hibernate.orm.panache.PanacheRepository;
import jakarta.enterprise.context.ApplicationScoped;

@ApplicationScoped
public class PlantCareRuleRepository implements PanacheRepository<PlantCareRuleEntity> {}
