package de.thws.powerplants.adapters.out.persistence.jpa.repositories;

import java.util.Optional;
import java.util.UUID;

import jakarta.enterprise.context.ApplicationScoped;

import de.thws.powerplants.adapters.out.persistence.jpa.entities.JpaAccount;
import io.quarkus.hibernate.orm.panache.PanacheRepositoryBase;

@ApplicationScoped
public class JpaAccountRepository implements PanacheRepositoryBase<JpaAccount, UUID> {

    public Optional<JpaAccount> findByPublicName(String publicName) {
        return find("publicName", publicName).firstResultOptional();
    }
}
