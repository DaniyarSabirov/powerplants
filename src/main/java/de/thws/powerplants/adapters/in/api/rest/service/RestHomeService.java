package de.thws.powerplants.adapters.in.api.rest.service;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

import jakarta.enterprise.context.ApplicationScoped;
import jakarta.inject.Inject;

import de.thws.powerplants.adapters.in.api.rest.json.JsonHome;
import de.thws.powerplants.adapters.in.api.rest.json.JsonMapper;
import de.thws.powerplants.core.domain.Home;
import de.thws.powerplants.core.ports.in.HomeServicePortIn;

@ApplicationScoped
public class RestHomeService {

    @Inject
    private HomeServicePortIn homeServicePortIn;

    @Inject
    private JsonMapper jsonMapper;

    public RestHomeService() {}

    public JsonHome createHome(JsonHome jsonHome) {

        Home home = jsonMapper.toHome(jsonHome);

        Home result = homeServicePortIn.createHome(home);

        return jsonMapper.toJsonHome(result);
    }

    public List<JsonHome> getHomes() {

        List<Home> homes = homeServicePortIn.getHomes();

        return homes.stream().map(jsonMapper::toJsonHome).toList();
    }

    public Optional<JsonHome> getHomeById(UUID homeId) {

        Optional<Home> home = homeServicePortIn.getHomeById(homeId);

        return home.map(jsonMapper::toJsonHome);
    }

    public JsonHome updateHomeById(UUID homeId, JsonHome jsonHome) {

        Home home = jsonMapper.toHome(jsonHome);

        Home result = homeServicePortIn.updateHomeById(homeId, home);

        return jsonMapper.toJsonHome(result);
    }

    public void deleteHomeById(UUID homeId) {
        homeServicePortIn.deleteHomeById(homeId);
    }
}
