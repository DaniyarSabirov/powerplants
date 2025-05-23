package de.thws.powerplants.adapters.in.api;

import de.thws.powerplants.adapters.in.api.json.JsonGroup;
import de.thws.powerplants.adapters.out.persistence.entities.GroupEntity;
import de.thws.powerplants.core.domain.Group;
import de.thws.powerplants.core.mappers.GroupMapper;
import de.thws.powerplants.core.services.GroupService;
import jakarta.inject.Inject;
import jakarta.ws.rs.*;
import jakarta.ws.rs.core.MediaType;
import jakarta.ws.rs.core.Response;
import java.util.List;
import java.util.UUID;

@Path("/homes/{home_id}/groups")
@Produces(MediaType.APPLICATION_JSON)
@Consumes(MediaType.APPLICATION_JSON)
public class GroupResource {

    @Inject
    private GroupService groupService;

    @POST
    public Response createGroup(@PathParam("home_id") UUID homeId, JsonGroup jsonGroup) {

        Group group = GroupMapper.toGroupDTO(jsonGroup);

        GroupEntity entity = groupService.createGroup(homeId, group);

        return Response.status(Response.Status.CREATED)
                .entity(GroupMapper.toJsonGroup(entity))
                .build();
    }

    @GET
    public List<JsonGroup> getGroups(@PathParam("home_id") UUID homeId) {
        List<GroupEntity> groupEntities = groupService.getGroupsByHomeId(homeId);
        return groupEntities.stream().map(GroupMapper::toJsonGroup).toList();
    }

    @DELETE
    @Path("/{groupId}")
    public Response deleteGroup(@PathParam("groupId") UUID groupId) {

        boolean deleted = groupService.deleteGroup(groupId);
        if (deleted) {
            return Response.status(Response.Status.NO_CONTENT).build();
        } else {
            return Response.status(Response.Status.NOT_FOUND).build();
        }
    }

    @PUT
    @Path("/{groupId}")
    public Response updateGroup(@PathParam("groupId") UUID groupId, JsonGroup jsonGroup) {
        Group updatedGroup = GroupMapper.toGroupDTO(jsonGroup);
        GroupEntity updatedEntity = groupService.updateGroup(groupId, updatedGroup);
        return Response.ok(GroupMapper.toJsonGroup(updatedEntity)).build();
    }
}
