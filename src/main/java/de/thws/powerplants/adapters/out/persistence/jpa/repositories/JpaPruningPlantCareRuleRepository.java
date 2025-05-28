package de.thws.powerplants.adapters.out.persistence.jpa.repositories;

import java.util.UUID;

import jakarta.enterprise.context.ApplicationScoped;

import de.thws.powerplants.adapters.out.persistence.jpa.entities.JpaPruningPlantCareRule;
import io.quarkus.hibernate.orm.panache.PanacheRepositoryBase;

@ApplicationScoped
public class JpaPruningPlantCareRuleRepository implements PanacheRepositoryBase<JpaPruningPlantCareRule, UUID> {}
