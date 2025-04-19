package de.thws.powerplants.adapters.out.repositories;

import de.thws.powerplants.adapters.out.entities.PruningPlantCareRuleEntity;
import io.quarkus.hibernate.orm.panache.PanacheRepository;
import jakarta.enterprise.context.ApplicationScoped;

@ApplicationScoped
public class PruningPlantCareRuleRepository implements PanacheRepository<PruningPlantCareRuleEntity> {}
