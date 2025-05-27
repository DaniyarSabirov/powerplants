package de.thws.powerplants.adapters.in.api.service;

import de.thws.powerplants.adapters.in.api.json.JsonMapper;
import de.thws.powerplants.core.ports.in.PlantServicePortIn;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.inject.Inject;

@ApplicationScoped
public class RestPlantService {

    @Inject
    private PlantServicePortIn plantServicePortIn;

    @Inject
    private JsonMapper jsonMapper;

    public RestPlantService() {}
}
