package de.thws.powerplants.adapters.out.persistence.jpa.service;

import jakarta.enterprise.context.ApplicationScoped;

import de.thws.powerplants.adapters.out.persistence.jpa.entities.JpaAccount;
import de.thws.powerplants.adapters.out.persistence.jpa.entities.JpaGroup;
import de.thws.powerplants.adapters.out.persistence.jpa.entities.JpaHome;
import de.thws.powerplants.adapters.out.persistence.jpa.entities.JpaPlant;
import de.thws.powerplants.core.domain.Account;
import de.thws.powerplants.core.domain.Group;
import de.thws.powerplants.core.domain.Home;
import de.thws.powerplants.core.domain.Plant;

@ApplicationScoped
public class JpaMapper {

    public JpaMapper() {}

    public Account toAccount(JpaAccount account) {

        Account result = new Account();

        result.setId(account.getId());
        result.setPublicName(account.getPublicName());
        result.setLoginName(account.getLoginName());
        result.setLoginPassword(account.getLoginPassword());
        result.setImageId(account.getImageId());

        return result;
    }

    public JpaAccount toJpaAccount(Account account) {

        JpaAccount result = new JpaAccount();

        result.setId(account.getId());
        result.setPublicName(account.getPublicName());
        result.setLoginName(account.getLoginName());
        result.setLoginPassword(account.getLoginPassword());
        result.setImageId(account.getImageId());

        return result;
    }

    public Home toHome(JpaHome home) {

        Home result = new Home();

        result.setId(home.getId());
        result.setPublicName(home.getPublicName());
        result.setDescription(home.getDescription());

        return result;
    }

    public JpaHome toJpaHome(Home home) {

        JpaHome result = new JpaHome();

        result.setId(home.getId());
        result.setPublicName(home.getPublicName());
        result.setDescription(home.getDescription());

        return result;
    }

    public Group toGroup(JpaGroup group) {

        Group result = new Group();

        result.setId(group.getId());
        result.setPublicName(group.getPublicName());
        result.setDescription(group.getDescription());
        result.setImageId(group.getImageId());

        return result;
    }

    public JpaGroup toJpaGroup(Group group) {

        JpaGroup result = new JpaGroup();

        result.setId(group.getId());
        result.setPublicName(group.getPublicName());
        result.setDescription(group.getDescription());
        result.setImageId(group.getImageId());

        return result;
    }

    public Plant toPlant(JpaPlant plant) {

        Plant result = new Plant();

        result.setId(plant.getId());
        result.setScientificName(plant.getScientificName());
        result.setPublicName(plant.getPublicName());
        result.setDescription(plant.getDescription());
        result.setImageId(plant.getImageId());

        return result;
    }

    public JpaPlant toJpaPlant(Plant plant) {

        JpaPlant result = new JpaPlant();

        result.setId(plant.getId());
        result.setScientificName(plant.getScientificName());
        result.setPublicName(plant.getPublicName());
        result.setDescription(plant.getDescription());
        result.setImageId(plant.getImageId());

        return result;
    }
}
