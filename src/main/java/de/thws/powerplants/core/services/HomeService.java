package de.thws.powerplants.core.services;

import de.thws.powerplants.core.domain.Home;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

public interface HomeService {

    Home createHome(Home home);

    List<Home> getHomes();

    Optional<Home> getHomeById(UUID homeId);

    Home updateHomeById(UUID homeId, Home home);

    void deleteHomeById(UUID homeId);
}
