package de.thws.powerplants.adapters.in.api.rest.json;

import jakarta.enterprise.context.ApplicationScoped;

import de.thws.powerplants.core.domain.Account;
import de.thws.powerplants.core.domain.Group;
import de.thws.powerplants.core.domain.Home;
import de.thws.powerplants.core.domain.Plant;

@ApplicationScoped
public class JsonMapper {

    public JsonMapper() {}

    public Account toAccount(JsonAccount account) {

        Account result = new Account();

        result.setId(account.getId());
        result.setPublicName(account.getPublicName());
        result.setLoginName(account.getLoginName());
        result.setLoginPassword(account.getLoginPassword());
        result.setImageId(account.getImageId());

        return result;
    }

    public JsonAccount toJsonAccount(Account account) {

        JsonAccount result = new JsonAccount();

        result.setId(account.getId());
        result.setPublicName(account.getPublicName());
        result.setLoginName(account.getLoginName());
        result.setLoginPassword(account.getLoginPassword());
        result.setImageId(account.getImageId());

        return result;
    }

    public Home toHome(JsonHome home) {

        Home result = new Home();

        result.setId(home.getId());
        result.setPublicName(home.getPublicName());
        result.setDescription(home.getDescription());

        return result;
    }

    public JsonHome toJsonHome(Home home) {

        JsonHome result = new JsonHome();

        result.setId(home.getId());
        result.setPublicName(home.getPublicName());
        result.setDescription(home.getDescription());

        return result;
    }

    public Group toGroup(JsonGroup group) {

        Group result = new Group();

        result.setId(group.getId());
        result.setPublicName(group.getPublicName());
        result.setDescription(group.getDescription());
        result.setImageId(group.getImageId());

        return result;
    }

    public JsonGroup toJsonGroup(Group group) {

        JsonGroup result = new JsonGroup();

        result.setId(group.getId());
        result.setPublicName(group.getPublicName());
        result.setDescription(group.getDescription());
        result.setImageId(group.getImageId());

        return result;
    }

    public Plant toPlant(JsonPlant plant) {

        Plant result = new Plant();

        result.setId(plant.getId());
        result.setScientificName(plant.getScientificName());
        result.setPublicName(plant.getPublicName());
        result.setDescription(plant.getDescription());
        result.setImageId(plant.getImageId());

        return result;
    }

    public JsonPlant toJsonPlant(Plant plant) {

        JsonPlant result = new JsonPlant();

        result.setId(plant.getId());
        result.setScientificName(plant.getScientificName());
        result.setPublicName(plant.getPublicName());
        result.setDescription(plant.getDescription());
        result.setImageId(plant.getImageId());

        return result;
    }
}
