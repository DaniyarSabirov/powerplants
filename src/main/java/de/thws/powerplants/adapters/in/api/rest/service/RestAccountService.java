package de.thws.powerplants.adapters.in.api.rest.service;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

import jakarta.enterprise.context.ApplicationScoped;
import jakarta.inject.Inject;

import de.thws.powerplants.adapters.in.api.rest.json.JsonAccount;
import de.thws.powerplants.adapters.in.api.rest.json.JsonMapper;
import de.thws.powerplants.core.domain.Account;
import de.thws.powerplants.core.ports.in.AccountServicePortIn;

@ApplicationScoped
public class RestAccountService {

    @Inject
    private AccountServicePortIn accountServicePortIn;

    @Inject
    private JsonMapper jsonMapper;

    public RestAccountService() {}

    public JsonAccount createAccount(JsonAccount jsonAccount) {

        Account account = jsonMapper.toAccount(jsonAccount);

        Account result = accountServicePortIn.createAccount(account);

        return jsonMapper.toJsonAccount(result);
    }

    public List<JsonAccount> getAccounts() {

        List<Account> accounts = accountServicePortIn.getAccounts();

        return accounts.stream().map(jsonMapper::toJsonAccount).toList();
    }

    public Optional<JsonAccount> getAccountById(UUID id) {

        Optional<Account> account = accountServicePortIn.getAccountById(id);

        return account.map(jsonMapper::toJsonAccount);
    }

    public JsonAccount updateAccountById(UUID id, JsonAccount jsonAccount) {

        Account account = jsonMapper.toAccount(jsonAccount);

        Account result = accountServicePortIn.updateAccountById(id, account);

        return jsonMapper.toJsonAccount(result);
    }

    public void deleteAccountById(UUID id) {

        accountServicePortIn.deleteAccountById(id);
    }

    public void addHomeToAccount(UUID accountId, UUID homeId) {
        accountServicePortIn.addHomeToAccount(accountId, homeId);
    }
}
