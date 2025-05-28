package de.thws.powerplants.core.services;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

import de.thws.powerplants.core.domain.Home;

public interface HomeService {

    Home createHome(Home home);

    List<Home> getHomes();

    Optional<Home> getHomeById(UUID homeId);

    Home updateHomeById(UUID homeId, Home home);

    void deleteHomeById(UUID homeId);
}
