package de.thws.powerplants.adapters.in;

import de.thws.powerplants.adapters.in.json.JsonPlant;
import de.thws.powerplants.adapters.out.entities.PlantEntity;
import de.thws.powerplants.application.dto.PlantDTO;
import de.thws.powerplants.core.mappers.PlantMapper;
import de.thws.powerplants.core.services.PlantService;
import jakarta.inject.Inject;
import jakarta.ws.rs.*;
import jakarta.ws.rs.core.MediaType;
import jakarta.ws.rs.core.Response;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

@Path("/plants")
@Produces(MediaType.APPLICATION_JSON)
@Consumes(MediaType.APPLICATION_JSON)
public class PlantsResource {
    @Inject
    PlantService plantService;

    @POST // create plant
    public Response createPlant(JsonPlant jsonPlant) {
        PlantDTO plantDTO = PlantMapper.toPlantDTO(jsonPlant);
        PlantEntity entity = plantService.createPlant(plantDTO);
        return Response.status(Response.Status.CREATED)
                .entity(PlantMapper.toJsonPlant(entity))
                .build();
    }

    @GET // get all the plants in group
    @Path("/{groupId}")
    public List<PlantEntity> getPlantsByGroup(@PathParam("groupId") UUID groupId) {
        return plantService.getPlantsByGroup(groupId);
    }

    @DELETE // delete plant
    @Path("/{plantId}")
    public Response deletePlant(@PathParam("plantId") UUID plantId) {
        boolean deleted = plantService.deletePlant(plantId);
        if (deleted) {
            return Response.status(Response.Status.NO_CONTENT).build();
        } else {
            return Response.status(Response.Status.NOT_FOUND).build();
        }
    }

    @GET // get concrete plant with the help of ID
    @Path("/{plantId}")
    public Response getPlantById(@PathParam("plantId") UUID plantId) {
        Optional<PlantEntity> plantOpt = plantService.getPlantById(plantId);
        return plantOpt.map(plant -> Response.ok(plant).build())
                .orElse(Response.status(Response.Status.NOT_FOUND).build());
    }

    @PUT // update plant
    @Path("/{plantId}")
    public Response updatePlant(@PathParam("plantId") UUID plantId, PlantDTO request) {
        Optional<PlantEntity> updatedPlant = plantService.updatePlant(plantId, request);
        return updatedPlant
                .map(plant -> Response.ok(plant).build())
                .orElse(Response.status(Response.Status.NOT_FOUND).build());
    }

    @GET // get all the plants
    @Path("")
    public Response getAllPlants() {
        List<PlantEntity> plants = plantService.getAllPlants();
        if (plants.isEmpty()) {
            return Response.status(Response.Status.NO_CONTENT).build();
        }
        return Response.ok(plants).build();
    }
}
