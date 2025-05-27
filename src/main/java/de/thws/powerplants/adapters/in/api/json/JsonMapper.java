package de.thws.powerplants.adapters.in.api.json;

import de.thws.powerplants.core.domain.Account;
import de.thws.powerplants.core.domain.Group;
import jakarta.enterprise.context.ApplicationScoped;

@ApplicationScoped
public class JsonMapper {

    public JsonMapper() {}

    public Account toAccount(JsonAccount account) {

        Account result = new Account();

        result.setId(account.getId());
        result.setPublicName(account.getPublicName());
        result.setLoginName(account.getLoginName());
        result.setLoginPassword(account.getLoginPassword());
        result.setPictureUrl(account.getPictureUrl());

        return result;
    }

    public JsonAccount toJsonAccount(Account account) {

        JsonAccount result = new JsonAccount();

        result.setId(account.getId());
        result.setPublicName(account.getPublicName());
        result.setLoginName(account.getLoginName());
        result.setLoginPassword(account.getLoginPassword());
        result.setPictureUrl(account.getPictureUrl());

        return result;
    }

    public Group toGroup(JsonGroup group) {

        Group result = new Group();

        result.setId(group.getId());
        result.setPublicName(group.getPublicName());
        result.setDescription(group.getDescription());
        result.setPictureUrl(group.getPictureUrl());

        return result;
    }

    public JsonGroup toJsonGroup(Group group) {

        JsonGroup result = new JsonGroup();

        result.setId(group.getId());
        result.setPublicName(group.getPublicName());
        result.setDescription(group.getDescription());
        result.setPictureUrl(group.getPictureUrl());

        return result;
    }
}
