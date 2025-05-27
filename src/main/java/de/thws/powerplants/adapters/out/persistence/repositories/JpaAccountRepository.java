package de.thws.powerplants.adapters.out.persistence.repositories;

import de.thws.powerplants.adapters.out.persistence.entities.JpaAccount;
import io.quarkus.hibernate.orm.panache.PanacheRepositoryBase;
import jakarta.enterprise.context.ApplicationScoped;
import java.util.Optional;
import java.util.UUID;

@ApplicationScoped
public class JpaAccountRepository implements PanacheRepositoryBase<JpaAccount, UUID> {

    public Optional<JpaAccount> findByPublicName(String publicName) {
        return find("publicName", publicName).firstResultOptional();
    }
}
