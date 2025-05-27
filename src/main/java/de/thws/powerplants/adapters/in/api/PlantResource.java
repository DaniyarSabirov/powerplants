package de.thws.powerplants.adapters.in.api;

import de.thws.powerplants.adapters.in.api.json.JsonPlant;
import de.thws.powerplants.adapters.in.api.service.RestPlantService;
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
    private RestPlantService plantService;

    @POST // create plant
    public Response createPlant(@PathParam("group_id") UUID groupId, JsonPlant jsonPlant) {

        JsonPlant result = plantService.createPlant(groupId, jsonPlant);

        return Response.status(Response.Status.CREATED).entity(result).build();
    }

    @GET // get all the plants
    @Path("")
    public Response getPlants(@PathParam("group_id") UUID groupId) {

        List<JsonPlant> jsonPlants = plantService.getPlants(groupId);

        return Response.ok(jsonPlants).build();
    }

    @GET // get concrete plant with the help of ID
    @Path("/{plantId}")
    public Response getPlantById(@PathParam("group_id") UUID groupId, @PathParam("plantId") UUID plantId) {

        Optional<JsonPlant> jsonPlant = plantService.getPlantById(groupId, plantId);
        if (jsonPlant.isEmpty()) {
            throw new NotFoundException();
        }

        return Response.ok(jsonPlant.get()).build();
    }

    @PUT // update plant
    @Path("/{plantId}")
    public Response updatePlantById(
            @PathParam("group_id") UUID groupId, @PathParam("plantId") UUID plantId, JsonPlant jsonPlant) {

        JsonPlant result = plantService.updatePlantById(groupId, plantId, jsonPlant);

        return Response.ok(result).build();
    }

    @DELETE // delete plant
    @Path("/{plantId}")
    public Response deletePlant(@PathParam("group_id") UUID groupId, @PathParam("plantId") UUID plantId) {

        plantService.deletePlantById(groupId, plantId);

        return Response.noContent().build();
    }

    /*@GET // get all the plants in group
    @Path("/{groupId}")
    public List<PlantEntity> getPlantsByGroup(@PathParam("groupId") UUID groupId) {
        return plantService.getPlantsByGroup(groupId);
    }*/
}
