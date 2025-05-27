package de.thws.powerplants.adapters.out.persistence.service;

import de.thws.powerplants.adapters.out.persistence.entities.JpaAccount;
import de.thws.powerplants.adapters.out.persistence.repositories.JpaAccountRepository;
import de.thws.powerplants.adapters.out.persistence.repositories.JpaHomeRepository;
import de.thws.powerplants.core.domain.Account;
import de.thws.powerplants.core.ports.out.AccountServicePortOut;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.inject.Inject;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

@ApplicationScoped
public class JpaAccountService implements AccountServicePortOut {

    @Inject
    private JpaAccountRepository jpaAccountRepository;

    @Inject
    private JpaHomeRepository jpaHomeRepository;

    @Inject
    private JpaMapper jpaMapper;

    public JpaAccountService() {}

    @Override
    public Account createAccount(Account account) {

        JpaAccount jpaAccount = jpaMapper.toJpaAccount(account);

        jpaAccountRepository.persist(jpaAccount);

        return jpaMapper.toAccount(jpaAccount);
    }

    @Override
    public List<Account> getAccounts() {
        return List.of();
    }

    @Override
    public Optional<Account> getAccountById(UUID id) {
        return Optional.empty();
    }

    @Override
    public Account updateAccountById(UUID id, Account account) {
        return null;
    }

    @Override
    public void deleteAccountById(UUID id) {}

    @Override
    public void addHomeToAccount(UUID accountId, UUID homeId) {

        var accountOpt = jpaAccountRepository.findByIdOptional(accountId);
        var homeOpt = jpaHomeRepository.findByIdOptional(homeId);

        if (accountOpt.isEmpty() || homeOpt.isEmpty()) {
            throw new IllegalStateException();
        }

        var account = accountOpt.get();
        var home = homeOpt.get();

        account.getHomes().add(home);
    }
}
