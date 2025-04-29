package de.thws.powerplants.adapters.out.repositories;

import de.thws.powerplants.adapters.out.entities.PlantEntity;
import io.quarkus.hibernate.orm.panache.PanacheRepositoryBase;
import jakarta.enterprise.context.ApplicationScoped;
import java.util.UUID;

@ApplicationScoped
public interface PlantRepository extends PanacheRepositoryBase<PlantEntity, UUID> {}
