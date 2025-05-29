package de.thws.powerplants.adapters.in.api.rest;

import java.io.InputStream;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

import jakarta.inject.Inject;
import jakarta.ws.rs.*;
import jakarta.ws.rs.core.MediaType;
import jakarta.ws.rs.core.Response;

import de.thws.powerplants.adapters.in.api.rest.json.JsonPlant;
import de.thws.powerplants.adapters.in.api.rest.service.RestPlantService;
import org.jboss.resteasy.reactive.PartType;
import org.jboss.resteasy.reactive.RestForm;

@Path("/groups/{group_id}/plants")
@Produces(MediaType.APPLICATION_JSON)
@Consumes(MediaType.APPLICATION_JSON)
public class PlantResource {

    @Inject
    private RestPlantService plantService;

    public PlantResource() {}

    @POST
    @Consumes(MediaType.MULTIPART_FORM_DATA)
    public Response createPlant(
            @PathParam("group_id") UUID groupId,
            @RestForm("plant") @PartType(MediaType.APPLICATION_JSON) JsonPlant jsonPlant,
            @RestForm InputStream image) {

        JsonPlant result = plantService.createPlant(groupId, jsonPlant, image);

        return Response.status(Response.Status.CREATED).entity(result).build();
    }

    @GET
    public Response getPlants(@PathParam("group_id") UUID groupId) {

        List<JsonPlant> jsonPlants = plantService.getPlants(groupId);

        return Response.ok(jsonPlants).build();
    }

    @GET
    @Path("/{plantId}")
    public Response getPlantById(@PathParam("group_id") UUID groupId, @PathParam("plantId") UUID plantId) {

        Optional<JsonPlant> jsonPlant = plantService.getPlantById(groupId, plantId);
        if (jsonPlant.isEmpty()) {
            throw new NotFoundException();
        }

        return Response.ok(jsonPlant.get()).build();
    }

    @PUT
    @Path("/{plantId}")
    @Consumes(MediaType.MULTIPART_FORM_DATA)
    public Response updatePlantById(
            @PathParam("group_id") UUID groupId,
            @PathParam("plantId") UUID plantId,
            @RestForm("plant") @PartType(MediaType.APPLICATION_JSON) JsonPlant jsonPlant,
            @RestForm InputStream image) {

        JsonPlant result = plantService.updatePlantById(groupId, plantId, jsonPlant, image);

        return Response.ok(result).build();
    }

    @DELETE
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
