package de.thws.powerplants.adapters.in;

import jakarta.ws.rs.*;
import jakarta.ws.rs.core.MediaType;
import jakarta.ws.rs.core.Response;

@Path("/")
@Consumes(MediaType.APPLICATION_JSON)
@Produces(MediaType.APPLICATION_JSON)
public class DispatcherResource {

    @GET
    public Response getDispatcherState() {
        return Response.ok().build();
    }
}
