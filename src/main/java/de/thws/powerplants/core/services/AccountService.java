package de.thws.powerplants.core.services;

import de.thws.powerplants.adapters.out.persistence.entities.AccountEntity;
import de.thws.powerplants.adapters.out.persistence.repositories.AccountRepository;
import de.thws.powerplants.adapters.out.persistence.repositories.HomeRepository;
import de.thws.powerplants.core.domain.Account;
import de.thws.powerplants.core.mappers.AccountMapper;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.inject.Inject;
import jakarta.transaction.Transactional;
import jakarta.ws.rs.WebApplicationException;
import java.util.List;
import java.util.UUID;
import java.util.stream.Collectors;

@ApplicationScoped
public class AccountService {

    @Inject
    HomeRepository homeRepository;

    @Inject
    AccountRepository accountRepository;

    public List<Account> getAllAccounts() {
        return accountRepository.findAll().stream().map(AccountMapper::toDomain).collect(Collectors.toList());
    }

    public Account getAccountById(UUID id) {
        return accountRepository
                .findByIdOptional(id)
                .map(AccountMapper::toDomain)
                .orElse(null);
    }

    @Transactional
    public void createAccount(Account account) {
        if (accountRepository.findByPublicName(account.getPublicName()).isPresent()) {
            throw new WebApplicationException("Public name already in use", 400);
        }

        AccountEntity entity = AccountMapper.toEntity(account, homeRepository);
        accountRepository.persist(entity);
    }

    @Transactional
    public boolean deleteAccount(UUID id) {
        return accountRepository.deleteById(id);
    }

    @Transactional
    public boolean updateAccount(UUID id, Account updatedAccount) {
        return accountRepository
                .findByIdOptional(id)
                .map(existing -> {
                    existing.setName(updatedAccount.getName());
                    existing.setPublicName(updatedAccount.getPublicName());
                    existing.setPassword(updatedAccount.getPassword());
                    existing.setPictureUrl(updatedAccount.getPictureUrl());
                    return true;
                })
                .orElse(false);
    }

    @Transactional
    public boolean addHomeToAccount(UUID accountId, UUID homeId) {
        var accountOpt = accountRepository.findByIdOptional(accountId);
        var homeOpt = homeRepository.findByIdOptional(homeId);

        if (accountOpt.isEmpty() || homeOpt.isEmpty()) {
            return false;
        }

        var account = accountOpt.get();
        var home = homeOpt.get();

        account.getHomes().add(home);

        return true;
    }
}
