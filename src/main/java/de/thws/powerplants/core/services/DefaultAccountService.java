package de.thws.powerplants.core.services;

import de.thws.powerplants.core.domain.Account;
import de.thws.powerplants.core.ports.in.AccountServicePortIn;
import de.thws.powerplants.core.ports.out.AccountServicePortOut;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.inject.Inject;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

@ApplicationScoped
public class DefaultAccountService implements AccountServicePortIn {

    @Inject
    private AccountServicePortOut accountServicePortOut;

    public DefaultAccountService() {}

    @Override
    public Account createAccount(Account account) {
        return accountServicePortOut.createAccount(account);
    }

    @Override
    public List<Account> getAccounts() {
        return accountServicePortOut.getAccounts();
    }

    @Override
    public Optional<Account> getAccountById(UUID accountId) {
        return accountServicePortOut.getAccountById(accountId);
    }

    @Override
    public Account updateAccountById(UUID accountId, Account account) {
        return accountServicePortOut.updateAccountById(accountId, account);
    }

    @Override
    public void deleteAccountById(UUID accountId) {
        accountServicePortOut.deleteAccountById(accountId);
    }

    @Override
    public void addHomeToAccount(UUID accountId, UUID homeId) {
        accountServicePortOut.addHomeToAccount(accountId, homeId);
    }
}
