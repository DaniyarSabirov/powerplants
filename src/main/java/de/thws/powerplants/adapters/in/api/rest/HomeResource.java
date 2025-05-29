package de.thws.powerplants.adapters.in.api.rest;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

import jakarta.inject.Inject;
import jakarta.ws.rs.*;
import jakarta.ws.rs.core.MediaType;
import jakarta.ws.rs.core.Response;

import de.thws.powerplants.adapters.in.api.rest.json.JsonHome;
import de.thws.powerplants.adapters.in.api.rest.service.RestHomeService;

@Path("/homes")
@Produces(MediaType.APPLICATION_JSON)
@Consumes(MediaType.APPLICATION_JSON)
public class HomeResource {

    @Inject
    private RestHomeService homeService;

    public HomeResource() {}

    @POST
    public Response createHome(JsonHome jsonHome) {

        JsonHome result = homeService.createHome(jsonHome);

        return Response.status(Response.Status.CREATED).entity(result).build();
    }

    @GET
    public Response getHomes() {

        List<JsonHome> jsonHomes = homeService.getHomes();

        return Response.ok(jsonHomes).build();
    }

    @GET
    @Path("/{id}")
    public Response getHomeById(@PathParam("id") UUID id) {

        Optional<JsonHome> jsonHome = homeService.getHomeById(id);
        if (jsonHome.isEmpty()) {
            throw new NotFoundException();
        }

        return Response.ok(jsonHome.get()).build();
    }

    @PUT
    @Path("/{id}")
    public Response updateHome(@PathParam("id") UUID id, JsonHome jsonHome) {
        JsonHome result = homeService.updateHomeById(id, jsonHome);
        return Response.ok(result).build();
    }

    @DELETE
    @Path("/{id}")
    public Response deleteHome(@PathParam("id") UUID id) {
        homeService.deleteHomeById(id);
        return Response.noContent().build();
    }
}
