package de.thws.powerplants.adapters.in.api.json;

import de.thws.powerplants.core.domain.Account;
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
}
