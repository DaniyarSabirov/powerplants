package de.thws.powerplants.adapters.out.persistence.repositories;

import de.thws.powerplants.adapters.out.persistence.entities.CustomPlantCareRuleEntity;
import io.quarkus.hibernate.orm.panache.PanacheRepositoryBase;
import jakarta.enterprise.context.ApplicationScoped;
import java.util.UUID;

@ApplicationScoped
public class CustomPlantCareRuleRepository implements PanacheRepositoryBase<CustomPlantCareRuleEntity, UUID> {}
