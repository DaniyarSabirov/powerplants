package de.thws.powerplants.adapters.in;


import de.thws.powerplants.application.dto.PlantRequest;
import de.thws.powerplants.infrastructure.persistence.entity.PlantEntity;
import jakarta.ws.rs.*;
import jakarta.ws.rs.core.MediaType;
import jakarta.ws.rs.core.Response;

import java.util.ArrayList;
import java.util.List;

@Path("/plants")
@Produces(MediaType.APPLICATION_JSON)
@Consumes(MediaType.APPLICATION_JSON)
public class PlantsResource {
    //create plant
    @POST
    public Response createPlant(PlantRequest plantRequest) {
        return Response.status(Response.Status.CREATED).build();
    }

    //get all the plants in group
    @GET
    @Path("/{groupId}")
    public List<PlantEntity> getPlantsByGroup(@PathParam("groupId") Long groupId) {
        return new ArrayList<>();
    }

    //delete plant
    @DELETE
    public Response deletePlant(@PathParam("plantId") Long plantId) {
        return Response.status(Response.Status.NOT_FOUND).build();
    }
}
