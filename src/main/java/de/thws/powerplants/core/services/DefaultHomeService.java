package de.thws.powerplants.core.services;

import de.thws.powerplants.core.domain.Home;
import de.thws.powerplants.core.ports.in.HomeServicePortIn;
import de.thws.powerplants.core.ports.out.HomeServicePortOut;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.inject.Inject;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

@ApplicationScoped
public class DefaultHomeService implements HomeServicePortIn {

    @Inject
    private HomeServicePortOut homeServicePortOut;

    public DefaultHomeService() {}

    @Override
    public Home createHome(Home home) {
        return homeServicePortOut.createHome(home);
    }

    @Override
    public List<Home> getHomes() {
        return homeServicePortOut.getHomes();
    }

    @Override
    public Optional<Home> getHomeById(UUID homeId) {
        return homeServicePortOut.getHomeById(homeId);
    }

    @Override
    public Home updateHomeById(UUID homeId, Home home) {
        return homeServicePortOut.updateHomeById(homeId, home);
    }

    @Override
    public void deleteHomeById(UUID homeId) {
        homeServicePortOut.deleteHomeById(homeId);
    }
}
