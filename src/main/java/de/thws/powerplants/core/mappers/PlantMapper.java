package de.thws.powerplants.core.mappers;

import de.thws.powerplants.adapters.in.api.json.JsonPlant;
import de.thws.powerplants.adapters.out.persistence.entities.PlantEntity;
import de.thws.powerplants.core.domain.Plant;

public class PlantMapper {

    public static Plant toPlantDTO(JsonPlant jsonPlant) {

        Plant plant = new Plant();

        plant.setScientificName(jsonPlant.getScientificName());
        plant.setPublicName(jsonPlant.getPublicName());
        plant.setDescription(jsonPlant.getDescription());
        plant.setPictureUrl(jsonPlant.getPictureUrl());

        return plant;
    }

    public static JsonPlant toJsonPlant(PlantEntity plantEntity) {

        JsonPlant plant = new JsonPlant();

        plant.setId(plantEntity.getId());
        plant.setScientificName(plantEntity.getScientificName());
        plant.setPublicName(plantEntity.getPublicName());
        plant.setDescription(plant.getDescription());
        plant.setPictureUrl(plantEntity.getPictureUrl());

        return plant;
    }
}
