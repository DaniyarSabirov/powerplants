package de.thws.powerplants.adapters.in.api;

import de.thws.powerplants.adapters.in.api.json.JsonGroup;
import de.thws.powerplants.adapters.in.api.service.RestGroupService;
import jakarta.inject.Inject;
import jakarta.ws.rs.*;
import jakarta.ws.rs.core.MediaType;
import jakarta.ws.rs.core.Response;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

@Path("/homes/{home_id}/groups")
@Produces(MediaType.APPLICATION_JSON)
@Consumes(MediaType.APPLICATION_JSON)
public class GroupResource {

    @Inject
    private RestGroupService groupService;

    @POST
    public Response createGroup(@PathParam("home_id") UUID homeId, JsonGroup jsonGroup) {

        JsonGroup result = groupService.createGroup(homeId, jsonGroup);

        return Response.status(Response.Status.CREATED).entity(result).build();
    }

    @GET
    public Response getGroups(@PathParam("home_id") UUID homeId) {

        List<JsonGroup> jsonGroups = groupService.getGroups(homeId);

        return Response.ok(jsonGroups).build();
    }

    @GET
    @Path("/{groupId}")
    public Response getGroupById(@PathParam("home_id") UUID homeId, @PathParam("groupId") UUID groupId) {

        Optional<JsonGroup> jsonGroup = groupService.getGroupById(homeId, groupId);
        if (jsonGroup.isEmpty()) {
            throw new NotFoundException();
        }

        return Response.ok(jsonGroup.get()).build();
    }

    @PUT
    @Path("/{groupId}")
    public Response updateGroupById(
            @PathParam("home_id") UUID homeId, @PathParam("groupId") UUID groupId, JsonGroup jsonGroup) {
        JsonGroup result = groupService.updateGroupById(homeId, groupId, jsonGroup);
        return Response.ok(result).build();
    }

    @DELETE
    @Path("/{groupId}")
    public Response deleteGroupById(@PathParam("home_id") UUID homeId, @PathParam("groupId") UUID groupId) {
        groupService.deleteGroupById(homeId, groupId);
        return Response.noContent().build();
    }
}
