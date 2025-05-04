package de.thws.powerplants.adapters.in.api;

import de.thws.powerplants.adapters.in.api.json.JsonGroup;
import de.thws.powerplants.adapters.out.persistence.entities.GroupEntity;
import de.thws.powerplants.core.services.GroupService;
import jakarta.inject.Inject;
import jakarta.transaction.Transactional;
import jakarta.ws.rs.*;
import jakarta.ws.rs.core.MediaType;
import jakarta.ws.rs.core.Response;

import java.util.List;
import java.util.UUID;

@Path("/groups")
@Produces(MediaType.APPLICATION_JSON)
@Consumes(MediaType.APPLICATION_JSON)
public class GroupResource {

    @Inject
    GroupService groupService;

    @POST
    @Transactional
    public Response createGroup(JsonGroup jsonGroup) {
        GroupEntity group = groupService.createGroup(
                jsonGroup.getPublicName(),
                jsonGroup.getDescription(),
                jsonGroup.getHomeId(),
                jsonGroup.getPictureUrl()
        );
        return Response.status(Response.Status.CREATED).entity(group).build();
    }

    @GET
    public List<GroupEntity> getAllGroups() {
        return groupService.getAllGroups();
    }

    @DELETE
    @Path("/{groupId}")
    public Response deleteGroup(@PathParam("groupId") UUID groupId) {
        groupService.deleteGroup(groupId);
        return Response.status(Response.Status.NO_CONTENT).build();
    }


}
