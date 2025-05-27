package de.thws.powerplants.adapters.out.persistence.service;

import de.thws.powerplants.adapters.out.persistence.entities.JpaAccount;
import de.thws.powerplants.adapters.out.persistence.entities.JpaGroup;
import de.thws.powerplants.core.domain.Account;
import de.thws.powerplants.core.domain.Group;
import jakarta.enterprise.context.ApplicationScoped;

@ApplicationScoped
public class JpaMapper {

    public JpaMapper() {}

    public Account toAccount(JpaAccount account) {

        Account result = new Account();

        result.setId(account.getId());
        result.setPublicName(account.getPublicName());
        result.setLoginName(account.getLoginName());
        result.setLoginPassword(account.getLoginPassword());
        result.setPictureUrl(account.getPictureUrl());

        return result;
    }

    public JpaAccount toJpaAccount(Account account) {

        JpaAccount result = new JpaAccount();

        result.setId(account.getId());
        result.setPublicName(account.getPublicName());
        result.setLoginName(account.getLoginName());
        result.setLoginPassword(account.getLoginPassword());
        result.setPictureUrl(account.getPictureUrl());

        return result;
    }

    public Group toGroup(JpaGroup group) {

        Group result = new Group();

        result.setId(group.getId());
        result.setPublicName(group.getPublicName());
        result.setDescription(group.getDescription());
        result.setPictureUrl(group.getPictureUrl());

        return result;
    }

    public JpaGroup toJpaGroup(Group group) {

        JpaGroup result = new JpaGroup();

        result.setId(group.getId());
        result.setPublicName(group.getPublicName());
        result.setDescription(group.getDescription());
        result.setPictureUrl(group.getPictureUrl());

        return result;
    }
}
