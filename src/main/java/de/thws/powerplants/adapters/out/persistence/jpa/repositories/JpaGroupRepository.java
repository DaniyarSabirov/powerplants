package de.thws.powerplants.adapters.out.persistence.jpa.repositories;

import de.thws.powerplants.adapters.out.persistence.jpa.entities.JpaGroup;
import io.quarkus.hibernate.orm.panache.PanacheRepositoryBase;
import jakarta.enterprise.context.ApplicationScoped;
import java.util.UUID;

@ApplicationScoped
public class JpaGroupRepository implements PanacheRepositoryBase<JpaGroup, UUID> {}
