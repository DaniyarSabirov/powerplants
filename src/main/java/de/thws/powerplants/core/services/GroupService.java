package de.thws.powerplants.core.services;

import de.thws.powerplants.adapters.out.persistence.entities.GroupEntity;
import de.thws.powerplants.adapters.out.persistence.entities.HomeEntity;
import de.thws.powerplants.adapters.out.persistence.repositories.GroupRepository;
import de.thws.powerplants.adapters.out.persistence.repositories.HomeRepository;
import de.thws.powerplants.core.domain.Group;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.inject.Inject;
import jakarta.transaction.Transactional;
import java.util.List;
import java.util.UUID;

@ApplicationScoped
public class GroupService {

    @Inject
    private HomeRepository homeRepository;

    @Inject
    private GroupRepository groupRepository;

    public GroupService() {}

    @Transactional
    public GroupEntity createGroup(UUID homeId, Group group) {

        HomeEntity homeEntity = homeRepository.findById(homeId);

        GroupEntity groupEntity = new GroupEntity();

        groupEntity.setPublicName(group.getPublicName());
        groupEntity.setDescription(group.getDescription());
        groupEntity.setPictureUrl(group.getPictureUrl());

        groupEntity.setHome(homeEntity);

        groupRepository.persist(groupEntity);

        return groupEntity;
    }

    @Transactional
    public List<GroupEntity> getAllGroups() {
        return groupRepository.listAll();
    }

    @Transactional
    public boolean deleteGroup(UUID groupId) {
        return groupRepository.deleteById(groupId);
    }
}
