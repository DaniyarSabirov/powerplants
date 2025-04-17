package de.thws.powerplants.adapters.out.repositories;

import de.thws.powerplants.adapters.out.entities.PlantCareRuleWaterEntity;
import io.quarkus.hibernate.orm.panache.PanacheRepository;
import jakarta.enterprise.context.ApplicationScoped;

@ApplicationScoped
public class PlantCareRuleWaterRepository implements PanacheRepository<PlantCareRuleWaterEntity> {}
