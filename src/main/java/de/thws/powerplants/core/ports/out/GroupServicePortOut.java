package de.thws.powerplants.core.ports.out;

import de.thws.powerplants.core.domain.Group;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

public interface GroupServicePortOut {

    Group createGroup(UUID homeId, Group group);

    List<Group> getGroups(UUID homeId);

    Optional<Group> getGroupById(UUID homeId, UUID groupId);

    Group updateGroupById(UUID homeId, UUID groupId, Group group);

    void deleteGroupById(UUID groupId);
}
