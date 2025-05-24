package de.thws.powerplants.adapters.in.api.service;

import de.thws.powerplants.adapters.in.api.json.JsonAccount;
import de.thws.powerplants.adapters.in.api.json.JsonMapper;
import de.thws.powerplants.core.domain.Account;
import de.thws.powerplants.core.ports.in.AccountServicePortIn;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.inject.Inject;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

@ApplicationScoped
public class RestAccountService {

    @Inject
    private AccountServicePortIn accountService;

    @Inject
    private JsonMapper jsonMapper;

    public RestAccountService() {}

    public JsonAccount createAccount(JsonAccount jsonAccount) {

        Account account = jsonMapper.toAccount(jsonAccount);

        Account result = accountService.createAccount(account);

        return jsonMapper.toJsonAccount(result);
    }

    public List<JsonAccount> getAccounts() {

        List<Account> accounts = accountService.getAccounts();

        return accounts.stream().map(jsonMapper::toJsonAccount).toList();
    }

    public Optional<JsonAccount> getAccountById(UUID id) {

        Optional<Account> account = accountService.getAccountById(id);

        return account.map(jsonMapper::toJsonAccount);
    }

    public JsonAccount updateAccountById(UUID id, JsonAccount jsonAccount) {

        Account account = jsonMapper.toAccount(jsonAccount);

        Account result = accountService.updateAccountById(id, account);

        return jsonMapper.toJsonAccount(result);
    }

    public void deleteAccountById(UUID id) {

        accountService.deleteAccountById(id);
    }

    public void addHomeToAccount(UUID accountId, UUID homeId) {
        accountService.addHomeToAccount(accountId, homeId);
    }
}
