package de.thws.powerplants.adapters.out.persistence.jpa.repositories;

import de.thws.powerplants.adapters.out.persistence.jpa.entities.JpaCustomJpaPlantCareRule;
import io.quarkus.hibernate.orm.panache.PanacheRepositoryBase;
import jakarta.enterprise.context.ApplicationScoped;
import java.util.UUID;

@ApplicationScoped
public class JpaCustomJpaPlantCareRuleRepository implements PanacheRepositoryBase<JpaCustomJpaPlantCareRule, UUID> {}
