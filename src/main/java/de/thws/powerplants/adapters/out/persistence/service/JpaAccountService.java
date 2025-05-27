package de.thws.powerplants.adapters.out.persistence.service;

import de.thws.powerplants.adapters.out.persistence.entities.JpaAccount;
import de.thws.powerplants.adapters.out.persistence.repositories.JpaAccountRepository;
import de.thws.powerplants.adapters.out.persistence.repositories.JpaHomeRepository;
import de.thws.powerplants.core.domain.Account;
import de.thws.powerplants.core.ports.out.AccountServicePortOut;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.inject.Inject;
import jakarta.transaction.Transactional;
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

    protected JpaAccount copyAccount(JpaAccount jpaAccount, Account account) {

        jpaAccount.setPublicName(account.getPublicName());
        jpaAccount.setLoginName(account.getLoginName());
        jpaAccount.setLoginPassword(account.getLoginPassword());
        jpaAccount.setPictureUrl(account.getPictureUrl());

        return jpaAccount;
    }

    @Override
    @Transactional
    public Account createAccount(Account account) {

        JpaAccount jpaAccount = jpaMapper.toJpaAccount(account);

        if (jpaAccountRepository.findByPublicName(jpaAccount.getPublicName()).isPresent()) {
            throw new IllegalStateException("Public name already in use"); // todo
        }

        jpaAccountRepository.persist(jpaAccount);

        return jpaMapper.toAccount(jpaAccount);
    }

    @Override
    @Transactional
    public List<Account> getAccounts() {

        return jpaAccountRepository.findAll().stream().map(jpaMapper::toAccount).toList();
    }

    @Override
    @Transactional
    public Optional<Account> getAccountById(UUID id) {

        return jpaAccountRepository.findByIdOptional(id).map(jpaMapper::toAccount);
    }

    @Override
    @Transactional
    public Account updateAccountById(UUID id, Account account) {

        return jpaAccountRepository
                .findByIdOptional(id)
                .map((v) -> copyAccount(v, account))
                .map(jpaMapper::toAccount)
                .orElseThrow();
    }

    @Override
    @Transactional
    public void deleteAccountById(UUID id) {
        jpaAccountRepository.deleteById(id);
    }

    @Override
    @Transactional
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
