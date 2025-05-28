package de.thws.powerplants.adapters.out.persistence.jpa.service;

import de.thws.powerplants.adapters.out.persistence.jpa.entities.JpaGroup;
import de.thws.powerplants.adapters.out.persistence.jpa.entities.JpaHome;
import de.thws.powerplants.adapters.out.persistence.jpa.repositories.JpaGroupRepository;
import de.thws.powerplants.adapters.out.persistence.jpa.repositories.JpaHomeRepository;
import de.thws.powerplants.core.domain.Group;
import de.thws.powerplants.core.ports.out.GroupServicePortOut;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.inject.Inject;
import jakarta.transaction.Transactional;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

@ApplicationScoped
public class JpaGroupService implements GroupServicePortOut {

    @Inject
    private JpaHomeRepository jpaHomeRepository;

    @Inject
    private JpaGroupRepository jpaGroupRepository;

    @Inject
    private JpaMapper jpaMapper;

    public JpaGroupService() {}

    protected JpaGroup copyGroup(JpaGroup jpaGroup, Group group) {

        // jpaGroup.setId(group.getId());
        jpaGroup.setPublicName(group.getPublicName());
        jpaGroup.setDescription(group.getDescription());
        jpaGroup.setPictureUrl(group.getPictureUrl());

        return jpaGroup;
    }

    @Override
    @Transactional
    public Group createGroup(UUID homeId, Group group) {

        JpaHome home = jpaHomeRepository.findById(homeId);
        if (home == null) {
            throw new NullPointerException(); // todo
        }

        JpaGroup jpaGroup = jpaMapper.toJpaGroup(group);

        jpaGroup.setHome(home);

        jpaGroupRepository.persist(jpaGroup);

        return jpaMapper.toGroup(jpaGroup);
    }

    @Override
    @Transactional
    public List<Group> getGroups(UUID homeId) {

        JpaHome home = jpaHomeRepository.findById(homeId);
        if (home == null) {
            throw new NullPointerException(); // todo
        }

        return home.getGroups().stream().map(jpaMapper::toGroup).toList();
    }

    @Override
    @Transactional
    public Optional<Group> getGroupById(UUID homeId, UUID groupId) {

        Optional<JpaGroup> group = jpaGroupRepository.findByIdOptional(groupId);

        return group.map(jpaMapper::toGroup);
    }

    @Override
    @Transactional
    public Group updateGroupById(UUID homeId, UUID groupId, Group group) {

        return jpaGroupRepository
                .findByIdOptional(groupId)
                .map((v) -> copyGroup(v, group))
                .map(jpaMapper::toGroup)
                .orElseThrow();
    }

    @Override
    @Transactional
    public void deleteGroupById(UUID homeId, UUID groupId) {
        jpaGroupRepository.deleteById(groupId);
    }
}
