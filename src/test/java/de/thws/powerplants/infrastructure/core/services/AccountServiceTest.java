package de.thws.powerplants.infrastructure.core.services;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.*;

import de.thws.powerplants.adapters.out.persistence.entities.JpaAccount;
import de.thws.powerplants.adapters.out.persistence.repositories.JpaAccountRepository;
import de.thws.powerplants.core.domain.Account;
import de.thws.powerplants.core.services.DefaultAccountService;
import io.quarkus.hibernate.orm.panache.PanacheQuery;
import jakarta.ws.rs.WebApplicationException;
import java.util.*;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.Disabled;
import org.junit.jupiter.api.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;

@Disabled
public class AccountServiceTest {

    @Mock
    JpaAccountRepository accountRepository;

    @InjectMocks
    DefaultAccountService accountService;

    private AutoCloseable mocks;

    private JpaAccount entity1;
    private JpaAccount entity2;

    // @BeforeEach
    void setUp() {
        mocks = MockitoAnnotations.openMocks(this);

        entity1 = new JpaAccount();
        entity1.setId(UUID.fromString("00000000-0000-0000-0000-000000000001"));
        entity1.setLoginName("User1");
        entity1.setPublicName("publicUser1");
        entity1.setLoginPassword("pass1");
        entity1.setPictureUrl("url1");

        entity2 = new JpaAccount();
        entity2.setId(UUID.fromString("00000000-0000-0000-0000-000000000002"));
        entity2.setLoginName("User2");
        entity2.setPublicName("publicUser2");
        entity2.setLoginPassword("pass2");
        entity2.setPictureUrl("url2");
    }

    @Test
    void testGetAllAccounts() {
        PanacheQuery<JpaAccount> panacheQuery = mock(PanacheQuery.class);

        when(accountRepository.findAll()).thenReturn(panacheQuery);
        when(panacheQuery.list()).thenReturn(List.of(entity1, entity2));

        List<Account> accounts = accountService.getAccounts();

        assertNotNull(accounts);
        assertEquals(2, accounts.size());

        assertEquals("User1", accounts.get(0).getLoginName());
        assertEquals("publicUser1", accounts.get(0).getPublicName());

        assertEquals("User2", accounts.get(1).getLoginName());
        assertEquals("publicUser2", accounts.get(1).getPublicName());

        verify(accountRepository, times(1)).findAll();
        verify(panacheQuery, times(1)).list();
    }

    @Test
    void testGetAccountByIdFound() {
        UUID testId = UUID.fromString("00000000-0000-0000-0000-000000000001");

        when(accountRepository.findByIdOptional(testId)).thenReturn(Optional.of(entity1));

        Optional<Account> result = accountService.getAccountById(testId);

        assertNotNull(result);
        assertTrue(result.isPresent());
        assertEquals("User1", result.get().getLoginName());
        verify(accountRepository, times(1)).findByIdOptional(testId);
    }

    @Test
    void testGetAccountByIdNotFound() {
        UUID testId = UUID.fromString("00000000-0000-0000-0000-000000000099");

        when(accountRepository.findByIdOptional(testId)).thenReturn(Optional.empty());

        Optional<Account> result = accountService.getAccountById(testId);

        assertTrue(result.isEmpty());
        verify(accountRepository, times(1)).findByIdOptional(testId);
    }

    @Test
    void testCreateAccountSuccess() {
        Account account = new Account();
        account.setId(UUID.randomUUID());
        account.setPublicName("uniquePublicName");
        account.setLoginName("UserName");
        account.setLoginPassword("pass");
        account.setPictureUrl("url");

        when(accountRepository.findByPublicName(account.getPublicName())).thenReturn(Optional.empty());

        doNothing().when(accountRepository).persist(any(JpaAccount.class));

        accountService.createAccount(account);

        verify(accountRepository, times(1)).findByPublicName(account.getPublicName());
        verify(accountRepository, times(1)).persist(any(JpaAccount.class));
    }

    @Test
    void testCreateAccountDuplicatePublicName() {
        Account account = new Account();
        account.setPublicName("takenPublicName");

        when(accountRepository.findByPublicName(account.getPublicName())).thenReturn(Optional.of(new JpaAccount()));

        WebApplicationException exception = assertThrows(WebApplicationException.class, () -> {
            accountService.createAccount(account);
        });

        assertEquals(400, exception.getResponse().getStatus());
        assertEquals("Public name already in use", exception.getMessage());

        verify(accountRepository, times(1)).findByPublicName(account.getPublicName());
        verify(accountRepository, never()).persist(any(JpaAccount.class));
    }

    @Test
    void testDeleteAccountSuccess() {
        UUID id = UUID.randomUUID();

        when(accountRepository.deleteById(id)).thenReturn(true);

        accountService.deleteAccountById(id);

        verify(accountRepository, times(1)).deleteById(id);
    }

    @Test
    void testDeleteAccountFail() {
        UUID id = UUID.randomUUID();

        when(accountRepository.deleteById(id)).thenReturn(false);

        accountService.deleteAccountById(id);

        verify(accountRepository, times(1)).deleteById(id);
    }

    @Test
    void testUpdateAccountSuccess() {
        UUID id = UUID.randomUUID();
        JpaAccount existingEntity = new JpaAccount();
        existingEntity.setId(id);
        existingEntity.setLoginName("OldName");
        existingEntity.setPublicName("OldPublicName");
        existingEntity.setLoginPassword("oldPass");
        existingEntity.setPictureUrl("oldUrl");

        Account updatedAccount = new Account();
        updatedAccount.setLoginName("NewName");
        updatedAccount.setPublicName("NewPublicName");
        updatedAccount.setLoginPassword("newPass");
        updatedAccount.setPictureUrl("newUrl");

        when(accountRepository.findByIdOptional(id)).thenReturn(Optional.of(existingEntity));

        Account account = accountService.updateAccountById(id, updatedAccount);

        assertNotNull(account);
        assertEquals("NewName", account.getLoginName());
        assertEquals("NewPublicName", existingEntity.getPublicName());
        assertEquals("newPass", account.getLoginPassword());
        assertEquals("newUrl", existingEntity.getPictureUrl());

        verify(accountRepository, times(1)).findByIdOptional(id);
    }

    @Test
    void testUpdateAccountNotFound() {
        UUID id = UUID.randomUUID();
        Account updatedAccount = new Account();

        when(accountRepository.findByIdOptional(id)).thenReturn(Optional.empty());

        Account result = accountService.updateAccountById(id, updatedAccount);

        assertNull(result);

        verify(accountRepository, times(1)).findByIdOptional(id);
    }

    @AfterEach
    void tearDown() throws Exception {
        mocks.close();
    }
}
