package de.thws.powerplants.adapters.in.api.rest;

import de.thws.powerplants.adapters.in.api.rest.service.RestImageService;
import jakarta.inject.Inject;
import jakarta.ws.rs.*;
import jakarta.ws.rs.core.MediaType;
import jakarta.ws.rs.core.Response;
import java.io.InputStream;
import java.util.UUID;

@Path("/images/{imageId}")
@Produces(MediaType.APPLICATION_OCTET_STREAM)
@Consumes(MediaType.APPLICATION_OCTET_STREAM)
public class ImageResource {

    @Inject
    private RestImageService imageService;

    @PUT
    public Response createImage(@PathParam("imageId") UUID imageId, InputStream inputStream) {

        imageService.createImage(imageId, inputStream);

        return Response.ok().build();
    }

    @GET
    public Response getImageById(@PathParam("imageId") UUID imageId) {

        InputStream inputStream = imageService.getImageById(imageId);

        return Response.ok(inputStream).build();
    }
}
