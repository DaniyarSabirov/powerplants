package de.thws.powerplants.core.services;

import de.thws.powerplants.core.domain.Account;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

public interface AccountService {

    Account createAccount(Account account);

    List<Account> getAccounts();

    Optional<Account> getAccountById(UUID accountId);

    Account updateAccountById(UUID accountId, Account account);

    void deleteAccountById(UUID accountId);

    void addHomeToAccount(UUID accountId, UUID homeId);
}
