package de.thws.powerplants.core.mappers;

import de.thws.powerplants.adapters.out.persistence.entities.AccountEntity;
import de.thws.powerplants.adapters.out.persistence.repositories.HomeRepository;
import de.thws.powerplants.core.domain.Account;
import java.util.stream.Collectors;

public class AccountMapper {
    public static Account toDomain(AccountEntity entity) {
        Account account = new Account();
        account.setId(entity.getId());
        account.setPublicName(entity.getPublicName());
        account.setName(entity.getName());
        account.setPassword(entity.getPassword());
        account.setPictureUrl(entity.getPictureUrl());
        account.setHomeIds(entity.getHomes().stream().map(home -> home.getId()).collect(Collectors.toList()));
        return account;
    }

    public static AccountEntity toEntity(Account domain, HomeRepository homeRepository) {
        AccountEntity entity = new AccountEntity();
        entity.setId(domain.getId());
        entity.setPublicName(domain.getPublicName());
        entity.setName(domain.getName());
        entity.setPassword(domain.getPassword());
        entity.setPictureUrl(domain.getPictureUrl());
        entity.setHomes(domain.getHomeIds().stream()
                .map(homeId -> homeRepository.findByIdOptional(homeId).orElse(null))
                .filter(home -> home != null)
                .collect(Collectors.toList()));
        return entity;
    }
}
