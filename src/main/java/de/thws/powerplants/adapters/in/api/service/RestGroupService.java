package de.thws.powerplants.adapters.in.api.service;

import de.thws.powerplants.adapters.in.api.json.JsonMapper;
import de.thws.powerplants.core.ports.in.GroupServicePortIn;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.inject.Inject;

@ApplicationScoped
public class RestGroupService {

    @Inject
    private GroupServicePortIn groupServicePortIn;

    @Inject
    private JsonMapper jsonMapper;

    public RestGroupService() {}
}
