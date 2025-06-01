package de.thws.powerplants.adapters.in.api.rest.service;

import java.io.InputStream;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

import jakarta.enterprise.context.ApplicationScoped;
import jakarta.inject.Inject;

import de.thws.powerplants.adapters.in.api.rest.json.JsonGroup;
import de.thws.powerplants.adapters.in.api.rest.json.JsonMapper;
import de.thws.powerplants.core.domain.Group;
import de.thws.powerplants.core.ports.in.GroupServicePortIn;
import de.thws.powerplants.core.ports.in.ImageServicePortIn;

@ApplicationScoped
public class RestGroupService {

    @Inject
    private GroupServicePortIn groupServicePortIn;

    @Inject
    private ImageServicePortIn imageServicePortIn;

    @Inject
    private JsonMapper jsonMapper;

    public RestGroupService() {}

    public JsonGroup createGroup(UUID homeId, JsonGroup jsonGroup, InputStream image) {

        Group group = jsonMapper.toGroup(jsonGroup);

        imageServicePortIn.updateImageInHolder(group, image);

        Group result = groupServicePortIn.createGroup(homeId, group);

        return jsonMapper.toJsonGroup(result);
    }

    public List<JsonGroup> getGroups(UUID homeId) {

        List<Group> result = groupServicePortIn.getGroups(homeId);

        return result.stream().map(jsonMapper::toJsonGroup).toList();
    }

    public Optional<JsonGroup> getGroupById(UUID homeId, UUID groupId) {

        Optional<Group> result = groupServicePortIn.getGroupById(homeId, groupId);

        return result.map(jsonMapper::toJsonGroup);
    }

    public JsonGroup updateGroupById(UUID homeId, UUID groupId, JsonGroup jsonGroup, InputStream image) {

        Group group = jsonMapper.toGroup(jsonGroup);

        imageServicePortIn.updateImageInHolder(group, image);

        Group result = groupServicePortIn.updateGroupById(homeId, groupId, group);

        return jsonMapper.toJsonGroup(result);
    }

    public void deleteGroupById(UUID homeId, UUID groupId) {
        groupServicePortIn.deleteGroupById(homeId, groupId);
    }
}
