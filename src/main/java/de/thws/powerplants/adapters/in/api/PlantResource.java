package de.thws.powerplants.adapters.in.api;

import de.thws.powerplants.adapters.in.api.json.JsonPlant;
import de.thws.powerplants.adapters.out.persistence.entities.PlantEntity;
import de.thws.powerplants.core.domain.Plant;
import de.thws.powerplants.core.mappers.PlantMapper;
import de.thws.powerplants.core.services.PlantService;
import jakarta.inject.Inject;
import jakarta.ws.rs.*;
import jakarta.ws.rs.core.MediaType;
import jakarta.ws.rs.core.Response;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

@Path("/groups/{group_id}/plants")
@Produces(MediaType.APPLICATION_JSON)
@Consumes(MediaType.APPLICATION_JSON)
public class PlantResource {

    @Inject
    private PlantService plantService;

    @POST // create plant
    public Response createPlant(@PathParam("group_id") UUID groupId, JsonPlant jsonPlant) {

        Plant plant = PlantMapper.toPlantDTO(jsonPlant);

        PlantEntity entity = plantService.createPlant(groupId, plant);

        return Response.status(Response.Status.CREATED)
                .entity(PlantMapper.toJsonPlant(entity))
                .build();
    }

    @GET // get all the plants
    @Path("")
    public Response getPlantsByGroup(@PathParam("group_id") UUID groupId) {

        List<JsonPlant> plants = plantService.getPlantsByGroup(groupId).stream()
                .map(PlantMapper::toJsonPlant)
                .toList();

        return Response.ok(plants).build();
    }

    @GET // get concrete plant with the help of ID
    @Path("/{plantId}")
    public Response getPlantById(@PathParam("plantId") UUID plantId) {

        Optional<JsonPlant> plantOpt = plantService.getPlantById(plantId).map(PlantMapper::toJsonPlant);
        if (plantOpt.isEmpty()) {
            return Response.status(Response.Status.NO_CONTENT).build();
        }

        return Response.ok(plantOpt.get()).build();
    }

    @PUT // update plant
    @Path("/{plantId}")
    public Response updatePlant(@PathParam("plantId") UUID plantId, JsonPlant jsonPlant) {

        Plant plant = PlantMapper.toPlantDTO(jsonPlant);

        Optional<JsonPlant> updatedPlant =
                plantService.updatePlant(plantId, plant).map(PlantMapper::toJsonPlant);
        if (updatedPlant.isEmpty()) {
            return Response.status(Response.Status.NO_CONTENT).build();
        }

        return Response.ok(updatedPlant.get()).build();
    }

    @DELETE // delete plant
    @Path("/{plantId}")
    public Response deletePlant(@PathParam("group_id") UUID groupId, @PathParam("plantId") UUID plantId) {

        boolean deleted = plantService.deletePlant(groupId, plantId);
        if (deleted) {
            return Response.status(Response.Status.NO_CONTENT).build();
        } else {
            return Response.status(Response.Status.NOT_FOUND).build();
        }
    }

    /*@GET // get all the plants in group
    @Path("/{groupId}")
    public List<PlantEntity> getPlantsByGroup(@PathParam("groupId") UUID groupId) {
        return plantService.getPlantsByGroup(groupId);
    }*/
}
