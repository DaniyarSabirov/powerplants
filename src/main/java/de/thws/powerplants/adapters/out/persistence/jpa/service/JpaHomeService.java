package de.thws.powerplants.adapters.out.persistence.jpa.service;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

import jakarta.enterprise.context.ApplicationScoped;
import jakarta.inject.Inject;
import jakarta.transaction.Transactional;

import de.thws.powerplants.adapters.out.persistence.jpa.entities.JpaHome;
import de.thws.powerplants.adapters.out.persistence.jpa.repositories.JpaHomeRepository;
import de.thws.powerplants.core.domain.Home;
import de.thws.powerplants.core.ports.out.HomeServicePortOut;

@ApplicationScoped
public class JpaHomeService implements HomeServicePortOut {

    @Inject
    private JpaHomeRepository jpaHomeRepository;

    @Inject
    private JpaMapper jpaMapper;

    public JpaHomeService() {}

    protected JpaHome copyHome(JpaHome jpaHome, Home home) {

        // jpaHome.setId(home.getId());
        jpaHome.setPublicName(home.getPublicName());
        jpaHome.setDescription(home.getDescription());

        return jpaHome;
    }

    @Override
    @Transactional
    public Home createHome(Home home) {

        JpaHome jpaHome = jpaMapper.toJpaHome(home);

        jpaHomeRepository.persist(jpaHome);

        return jpaMapper.toHome(jpaHome);
    }

    @Override
    @Transactional
    public List<Home> getHomes() {

        return jpaHomeRepository.findAll().stream().map(jpaMapper::toHome).toList();
    }

    @Override
    @Transactional
    public Optional<Home> getHomeById(UUID homeId) {

        return jpaHomeRepository.findByIdOptional(homeId).map(jpaMapper::toHome);
    }

    @Override
    @Transactional
    public Home updateHomeById(UUID homeId, Home home) {

        return jpaHomeRepository
                .findByIdOptional(homeId)
                .map((v) -> copyHome(v, home))
                .map(jpaMapper::toHome)
                .orElseThrow();
    }

    @Override
    @Transactional
    public void deleteHomeById(UUID homeId) {
        jpaHomeRepository.deleteById(homeId);
    }
}
