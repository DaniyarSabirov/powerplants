package de.thws.powerplants.adapters.out.persistence.repositories;

import de.thws.powerplants.adapters.out.persistence.entities.GroupEntity;
import io.quarkus.hibernate.orm.panache.PanacheRepository;
import jakarta.enterprise.context.ApplicationScoped;

@ApplicationScoped
public class GroupRepository implements PanacheRepository<GroupEntity> {}
