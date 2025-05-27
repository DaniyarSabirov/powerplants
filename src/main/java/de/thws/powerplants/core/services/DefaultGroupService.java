package de.thws.powerplants.core.services;

import de.thws.powerplants.core.domain.Group;
import de.thws.powerplants.core.ports.in.GroupServicePortIn;
import de.thws.powerplants.core.ports.out.GroupServicePortOut;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.inject.Inject;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

@ApplicationScoped
public class DefaultGroupService implements GroupServicePortIn {

    @Inject
    private GroupServicePortOut groupServicePortOut;

    public DefaultGroupService() {}

    @Override
    public Group createGroup(UUID homeId, Group group) {
        return groupServicePortOut.createGroup(homeId, group);
    }

    @Override
    public List<Group> getGroups(UUID homeId) {
        return groupServicePortOut.getGroups(homeId);
    }

    @Override
    public Optional<Group> getGroupById(UUID homeId, UUID groupId) {
        return groupServicePortOut.getGroupById(homeId, groupId);
    }

    @Override
    public Group updateGroupById(UUID homeId, UUID groupId, Group group) {
        return groupServicePortOut.updateGroupById(homeId, groupId, group);
    }

    @Override
    public void deleteGroupById(UUID homeId, UUID groupId) {
        groupServicePortOut.deleteGroupById(homeId, groupId);
    }
}
