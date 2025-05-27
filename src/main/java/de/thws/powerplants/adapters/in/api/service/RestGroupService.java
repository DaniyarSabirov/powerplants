package de.thws.powerplants.adapters.in.api.service;

import de.thws.powerplants.adapters.in.api.json.JsonGroup;
import de.thws.powerplants.adapters.in.api.json.JsonMapper;
import de.thws.powerplants.core.ports.in.GroupServicePortIn;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.inject.Inject;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

@ApplicationScoped
public class RestGroupService {

    @Inject
    private GroupServicePortIn groupServicePortIn;

    @Inject
    private JsonMapper jsonMapper;

    public RestGroupService() {}

    public JsonGroup createGroup(UUID homeId, JsonGroup jsonGroup) {
        return null;
    }

    public List<JsonGroup> getGroups(UUID homeId) {
        return null;
    }

    public Optional<JsonGroup> getGroupById(UUID homeId, UUID groupId) {
        return null;
    }

    public JsonGroup updateGroupById(UUID homeId, UUID groupId, JsonGroup jsonGroup) {
        return null;
    }

    public void deleteGroupById(UUID homeId, UUID groupId) {}
}
