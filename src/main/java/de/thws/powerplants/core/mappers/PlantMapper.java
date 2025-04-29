package de.thws.powerplants.core.mappers;

import de.thws.powerplants.adapters.in.api.json.JsonPlant;
import de.thws.powerplants.adapters.out.persistence.entities.PlantEntity;
import de.thws.powerplants.core.domain.Plant;

public class PlantMapper {
    public static Plant toPlantDTO(JsonPlant jsonPlant) {
        return new Plant();
    }

    public static JsonPlant toJsonPlant(PlantEntity plantEntity) {
        return new JsonPlant();
    }

    public static PlantEntity toPlantEntity(Plant plant) {
        return new PlantEntity();
    }
}
