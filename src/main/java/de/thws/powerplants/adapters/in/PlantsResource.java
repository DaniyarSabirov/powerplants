package de.thws.powerplants.adapters.in;

import de.thws.powerplants.adapters.out.entities.PlantEntity;
import de.thws.powerplants.adapters.out.repositories.PlantRepository;
import de.thws.powerplants.application.dto.PlantRequest;
import jakarta.inject.Inject;
import jakarta.ws.rs.*;
import jakarta.ws.rs.core.MediaType;
import jakarta.ws.rs.core.Response;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

@Path("/plants")
@Produces(MediaType.APPLICATION_JSON)
@Consumes(MediaType.APPLICATION_JSON)
public class PlantsResource {

    @Inject
    PlantRepository plantRepository;

    @POST // create plant
    public Response createPlant(PlantRequest plantRequest) {
        PlantEntity newPlant = new PlantEntity();
        newPlant.setPublicName(plantRequest.getPublicName());
        newPlant.setScientificName(plantRequest.getScientificName());
        newPlant.setDescription(plantRequest.getDescription());
        newPlant.setPictureUrl(plantRequest.getPictureUrl());

        plantRepository.persist(newPlant);

        return Response.status(Response.Status.CREATED).entity(newPlant).build();
    }

    @GET // get all the plants in group
    @Path("/{groupId}")
    public List<PlantEntity> getPlantsByGroup(@PathParam("groupId") UUID groupId) {
        return plantRepository
                .find("SELECT p FROM PlantEntity p WHERE p.group.id = ?1", groupId)
                .list();
    }

    @DELETE // delete plant
    @Path("/{plantId}")
    public Response deletePlant(@PathParam("plantId") UUID plantId) {
        Optional<PlantEntity> plantOpt = plantRepository.findByIdOptional(plantId);
        if (plantOpt.isPresent()) {
            plantRepository.delete(plantOpt.get());
            return Response.status(Response.Status.NO_CONTENT).build();
        } else {
            return Response.status(Response.Status.NOT_FOUND).build();
        }
    }

    @GET // get the Plant with help of ID
    @Path("/{plantId}")
    public Response getPlantById(@PathParam("plantId") UUID plantId) {
        Optional<PlantEntity> plantOpt = plantRepository.findByIdOptional(plantId);
        return plantOpt.map(plant -> Response.ok(plant).build())
                .orElse(Response.status(Response.Status.NOT_FOUND).build());
    }

    @PUT // update plant
    @Path("/{plantId}")
    public Response updatePlant(@PathParam("plantId") UUID plantId, PlantRequest request) {
        Optional<PlantEntity> plantOpt = plantRepository.findByIdOptional(plantId);
        if (plantOpt.isEmpty()) {
            return Response.status(Response.Status.NOT_FOUND).build();
        }

        PlantEntity plant = plantOpt.get();
        plant.setPublicName(request.getPublicName());
        plant.setScientificName(request.getScientificName());
        plant.setDescription(request.getDescription());
        plant.setPictureUrl(request.getPictureUrl());

        plantRepository.persist(plant);

        return Response.ok(plant).build();
    }
}
