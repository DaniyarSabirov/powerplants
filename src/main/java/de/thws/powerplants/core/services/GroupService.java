package de.thws.powerplants.core.services;

import de.thws.powerplants.adapters.out.persistence.entities.GroupEntity;
import de.thws.powerplants.adapters.out.persistence.entities.HomeEntity;
import de.thws.powerplants.adapters.out.persistence.repositories.GroupRepository;
import de.thws.powerplants.adapters.out.persistence.repositories.HomeRepository;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.transaction.Transactional;

import java.util.List;
import java.util.UUID;

@ApplicationScoped
public class GroupService {

    private final GroupRepository groupRepository;
    private final HomeRepository homeRepository;

    public GroupService(GroupRepository groupRepository, HomeRepository homeRepository) {
        this.groupRepository = groupRepository;
        this.homeRepository = homeRepository;
    }

    @Transactional
    public GroupEntity createGroup(String publicName, String description, UUID homeId, String pictureUrl) {
        GroupEntity group = new GroupEntity();
        group.setPublicName(publicName);
        group.setDescription(description);
        group.setPictureUrl(pictureUrl);

        HomeEntity home = homeRepository.findById(homeId);
        if (home == null) {
            throw new IllegalArgumentException("Home with the specified ID not found");
        }
        group.setHome(home);

        groupRepository.persist(group);
        return group;
    }

    public List<GroupEntity> getAllGroups() {
        return groupRepository.listAll();
    }

    @Transactional
    public void deleteGroup(UUID groupId) {
        GroupEntity group = groupRepository.findById(groupId);
        if (group == null) {
            throw new IllegalArgumentException("Group with the provided ID not found");
        }
        groupRepository.delete(group);
    }
}
