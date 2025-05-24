package de.thws.powerplants.core.ports.out;

import de.thws.powerplants.core.domain.Account;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

public interface AccountServicePortOut {

    Account createAccount(Account account);

    List<Account> getAccounts();

    Optional<Account> getAccountById(UUID id);

    Account updateAccountById(UUID id, Account account);

    void deleteAccountById(UUID id);
}
