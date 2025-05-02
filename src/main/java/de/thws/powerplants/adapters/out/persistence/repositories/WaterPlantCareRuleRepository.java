package de.thws.powerplants.adapters.out.persistence.repositories;

import de.thws.powerplants.adapters.out.persistence.entities.WaterPlantCareRuleEntity;
import io.quarkus.hibernate.orm.panache.PanacheRepositoryBase;
import jakarta.enterprise.context.ApplicationScoped;
import java.util.UUID;

@ApplicationScoped
public class WaterPlantCareRuleRepository implements PanacheRepositoryBase<WaterPlantCareRuleEntity, UUID> {}
