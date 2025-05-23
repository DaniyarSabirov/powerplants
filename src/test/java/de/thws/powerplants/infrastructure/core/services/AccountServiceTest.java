package de.thws.powerplants.infrastructure.core.services;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.*;

import de.thws.powerplants.adapters.out.persistence.entities.AccountEntity;
import de.thws.powerplants.adapters.out.persistence.repositories.AccountRepository;
import de.thws.powerplants.core.domain.Account;
import de.thws.powerplants.core.services.AccountService;
import io.quarkus.hibernate.orm.panache.PanacheQuery;
import jakarta.ws.rs.WebApplicationException;
import java.util.*;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;

public class AccountServiceTest {

    @Mock
    AccountRepository accountRepository;

    @InjectMocks
    AccountService accountService;

    private AutoCloseable mocks;

    private AccountEntity entity1;
    private AccountEntity entity2;

    @BeforeEach
    void setUp() {
        mocks = MockitoAnnotations.openMocks(this);

        entity1 = new AccountEntity();
        entity1.setId(UUID.fromString("00000000-0000-0000-0000-000000000001"));
        entity1.setName("User1");
        entity1.setPublicName("publicUser1");
        entity1.setPassword("pass1");
        entity1.setPictureUrl("url1");

        entity2 = new AccountEntity();
        entity2.setId(UUID.fromString("00000000-0000-0000-0000-000000000002"));
        entity2.setName("User2");
        entity2.setPublicName("publicUser2");
        entity2.setPassword("pass2");
        entity2.setPictureUrl("url2");
    }

    @Test
    void testGetAllAccounts() {
        PanacheQuery<AccountEntity> panacheQuery = mock(PanacheQuery.class);

        when(accountRepository.findAll()).thenReturn(panacheQuery);
        when(panacheQuery.list()).thenReturn(List.of(entity1, entity2));

        List<Account> accounts = accountService.getAllAccounts();

        assertNotNull(accounts);
        assertEquals(2, accounts.size());

        assertEquals("User1", accounts.get(0).getName());
        assertEquals("publicUser1", accounts.get(0).getPublicName());

        assertEquals("User2", accounts.get(1).getName());
        assertEquals("publicUser2", accounts.get(1).getPublicName());

        verify(accountRepository, times(1)).findAll();
        verify(panacheQuery, times(1)).list();
    }

    @Test
    void testGetAccountByIdFound() {
        UUID testId = UUID.fromString("00000000-0000-0000-0000-000000000001");

        when(accountRepository.findByIdOptional(testId)).thenReturn(Optional.of(entity1));

        Account result = accountService.getAccountById(testId);

        assertNotNull(result);
        assertEquals("User1", result.getName());
        verify(accountRepository, times(1)).findByIdOptional(testId);
    }

    @Test
    void testGetAccountByIdNotFound() {
        UUID testId = UUID.fromString("00000000-0000-0000-0000-000000000099");

        when(accountRepository.findByIdOptional(testId)).thenReturn(Optional.empty());

        Account result = accountService.getAccountById(testId);

        assertNull(result);
        verify(accountRepository, times(1)).findByIdOptional(testId);
    }

    @Test
    void testCreateAccountSuccess() {
        Account account = new Account();
        account.setId(UUID.randomUUID());
        account.setPublicName("uniquePublicName");
        account.setName("UserName");
        account.setPassword("pass");
        account.setPictureUrl("url");

        when(accountRepository.findByPublicName(account.getPublicName())).thenReturn(Optional.empty());

        doNothing().when(accountRepository).persist(any(AccountEntity.class));

        accountService.createAccount(account);

        verify(accountRepository, times(1)).findByPublicName(account.getPublicName());
        verify(accountRepository, times(1)).persist(any(AccountEntity.class));
    }

    @Test
    void testCreateAccountDuplicatePublicName() {
        Account account = new Account();
        account.setPublicName("takenPublicName");

        when(accountRepository.findByPublicName(account.getPublicName())).thenReturn(Optional.of(new AccountEntity()));

        WebApplicationException exception = assertThrows(WebApplicationException.class, () -> {
            accountService.createAccount(account);
        });

        assertEquals(400, exception.getResponse().getStatus());
        assertEquals("Public name already in use", exception.getMessage());

        verify(accountRepository, times(1)).findByPublicName(account.getPublicName());
        verify(accountRepository, never()).persist(any(AccountEntity.class));
    }

    @Test
    void testDeleteAccountSuccess() {
        UUID id = UUID.randomUUID();

        when(accountRepository.deleteById(id)).thenReturn(true);

        boolean result = accountService.deleteAccount(id);

        assertTrue(result);
        verify(accountRepository, times(1)).deleteById(id);
    }

    @Test
    void testDeleteAccountFail() {
        UUID id = UUID.randomUUID();

        when(accountRepository.deleteById(id)).thenReturn(false);

        boolean result = accountService.deleteAccount(id);

        assertFalse(result);
        verify(accountRepository, times(1)).deleteById(id);
    }

    @Test
    void testUpdateAccountSuccess() {
        UUID id = UUID.randomUUID();
        AccountEntity existingEntity = new AccountEntity();
        existingEntity.setId(id);
        existingEntity.setName("OldName");
        existingEntity.setPublicName("OldPublicName");
        existingEntity.setPassword("oldPass");
        existingEntity.setPictureUrl("oldUrl");

        Account updatedAccount = new Account();
        updatedAccount.setName("NewName");
        updatedAccount.setPublicName("NewPublicName");
        updatedAccount.setPassword("newPass");
        updatedAccount.setPictureUrl("newUrl");

        when(accountRepository.findByIdOptional(id)).thenReturn(Optional.of(existingEntity));

        boolean result = accountService.updateAccount(id, updatedAccount);

        assertTrue(result);
        assertEquals("NewName", existingEntity.getName());
        assertEquals("NewPublicName", existingEntity.getPublicName());
        assertEquals("newPass", existingEntity.getPassword());
        assertEquals("newUrl", existingEntity.getPictureUrl());

        verify(accountRepository, times(1)).findByIdOptional(id);
    }

    @Test
    void testUpdateAccountNotFound() {
        UUID id = UUID.randomUUID();
        Account updatedAccount = new Account();

        when(accountRepository.findByIdOptional(id)).thenReturn(Optional.empty());

        boolean result = accountService.updateAccount(id, updatedAccount);

        assertFalse(result);

        verify(accountRepository, times(1)).findByIdOptional(id);
    }

    @AfterEach
    void tearDown() throws Exception {
        mocks.close();
    }
}
