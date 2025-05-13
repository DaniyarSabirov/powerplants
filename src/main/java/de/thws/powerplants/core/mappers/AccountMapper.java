package de.thws.powerplants.core.mappers;

import de.thws.powerplants.adapters.in.api.json.JsonAccount;
import de.thws.powerplants.adapters.out.persistence.entities.AccountEntity;
import de.thws.powerplants.core.domain.Account;

public class AccountMapper {
    public static Account toDomain(AccountEntity entity) {
        Account account = new Account();
        account.setId(entity.getId());
        account.setPublicName(entity.getPublicName());
        account.setName(entity.getName());
        account.setPassword(entity.getPassword());
        account.setPictureUrl(entity.getPictureUrl());
        return account;
    }

    public static AccountEntity toEntity(Account domain) {
        AccountEntity entity = new AccountEntity();
        entity.setId(domain.getId());
        entity.setPublicName(domain.getPublicName());
        entity.setName(domain.getName());
        entity.setPassword(domain.getPassword());
        entity.setPictureUrl(domain.getPictureUrl());
        return entity;
    }

    public static JsonAccount toJsonAccount(Account account) {
        JsonAccount result = new JsonAccount();
        result.setId(account.getId());
        result.setPublicName(account.getPublicName());
        result.setName(account.getName());
        result.setPassword(account.getPassword());
        result.setPictureUrl(account.getPictureUrl());
        return result;
    }
}
