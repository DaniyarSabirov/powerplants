package de.thws.powerplants.core.mappers;

import de.thws.powerplants.adapters.in.api.json.JsonPlant;
import de.thws.powerplants.adapters.out.persistence.entities.PlantEntity;
import de.thws.powerplants.application.dto.PlantDTO;

public class PlantMapper {
    public static PlantDTO toPlantDTO(JsonPlant jsonPlant) {
        return new PlantDTO();
    }

    public static JsonPlant toJsonPlant(PlantEntity plantEntity) {
        return new JsonPlant();
    }

    public static PlantEntity toPlantEntity(PlantDTO plantDTO) {
        return new PlantEntity();
    }
}
