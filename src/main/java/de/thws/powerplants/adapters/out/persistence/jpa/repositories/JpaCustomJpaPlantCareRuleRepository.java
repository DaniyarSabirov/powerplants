package de.thws.powerplants.adapters.out.persistence.jpa.repositories;

import java.util.UUID;

import jakarta.enterprise.context.ApplicationScoped;

import de.thws.powerplants.adapters.out.persistence.jpa.entities.JpaCustomJpaPlantCareRule;
import io.quarkus.hibernate.orm.panache.PanacheRepositoryBase;

@ApplicationScoped
public class JpaCustomJpaPlantCareRuleRepository implements PanacheRepositoryBase<JpaCustomJpaPlantCareRule, UUID> {}
