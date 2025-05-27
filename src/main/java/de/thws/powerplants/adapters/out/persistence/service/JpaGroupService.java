package de.thws.powerplants.adapters.out.persistence.service;

import de.thws.powerplants.adapters.out.persistence.repositories.JpaGroupRepository;
import de.thws.powerplants.core.domain.Group;
import de.thws.powerplants.core.ports.out.GroupServicePortOut;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.inject.Inject;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

@ApplicationScoped
public class JpaGroupService implements GroupServicePortOut {

    @Inject
    private JpaGroupRepository jpaGroupRepository;

    @Inject
    private JpaMapper jpaMapper;

    public JpaGroupService() {}

    @Override
    public Group createGroup(UUID homeId, Group group) {
        return null;
    }

    @Override
    public List<Group> getGroups(UUID homeId) {
        return List.of();
    }

    @Override
    public Optional<Group> getGroupById(UUID homeId, UUID groupId) {
        return Optional.empty();
    }

    @Override
    public Group updateGroupById(UUID homeId, UUID groupId, Group group) {
        return null;
    }

    @Override
    public void deleteGroupById(UUID homeId, UUID groupId) {}
}
