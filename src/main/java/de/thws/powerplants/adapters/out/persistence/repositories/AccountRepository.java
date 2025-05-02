package de.thws.powerplants.adapters.out.persistence.repositories;

import de.thws.powerplants.adapters.out.persistence.entities.AccountEntity;
import io.quarkus.hibernate.orm.panache.PanacheRepository;
import jakarta.enterprise.context.ApplicationScoped;

@ApplicationScoped
public class AccountRepository implements PanacheRepository<AccountEntity> {}
