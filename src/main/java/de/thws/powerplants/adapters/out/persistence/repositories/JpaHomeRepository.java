package de.thws.powerplants.adapters.out.persistence.repositories;

import de.thws.powerplants.adapters.out.persistence.entities.JpaHome;
import io.quarkus.hibernate.orm.panache.PanacheRepositoryBase;
import jakarta.enterprise.context.ApplicationScoped;
import java.util.UUID;

@ApplicationScoped
public class JpaHomeRepository implements PanacheRepositoryBase<JpaHome, UUID> {}
