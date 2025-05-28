package de.thws.powerplants.adapters.in.api.rest;

import java.io.InputStream;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

import jakarta.inject.Inject;
import jakarta.ws.rs.*;
import jakarta.ws.rs.core.MediaType;
import jakarta.ws.rs.core.Response;

import de.thws.powerplants.adapters.in.api.rest.json.JsonAccount;
import de.thws.powerplants.adapters.in.api.rest.service.RestAccountService;
import org.jboss.resteasy.reactive.PartType;
import org.jboss.resteasy.reactive.RestForm;

@Path("/accounts")
@Produces(MediaType.APPLICATION_JSON)
@Consumes(MediaType.APPLICATION_JSON)
public class AccountResource {

    @Inject
    private RestAccountService accountService;

    @POST
    @Consumes(MediaType.MULTIPART_FORM_DATA)
    public Response createAccount(
            @RestForm("account") @PartType(MediaType.APPLICATION_JSON) JsonAccount jsonAccount,
            @RestForm InputStream image) {

        JsonAccount result = accountService.createAccount(jsonAccount);

        return Response.status(Response.Status.CREATED).entity(result).build();
    }

    @GET
    public Response getAccounts() {

        List<JsonAccount> jsonAccounts = accountService.getAccounts();

        return Response.ok(jsonAccounts).build();
    }

    @GET
    @Path("/{id}")
    public Response getAccountById(@PathParam("id") UUID id) {

        Optional<JsonAccount> jsonAccount = accountService.getAccountById(id);
        if (jsonAccount.isEmpty()) {
            throw new NotFoundException();
        }

        return Response.ok(jsonAccount.get()).build();
    }

    @PUT
    @Path("/{id}")
    @Consumes(MediaType.MULTIPART_FORM_DATA)
    public Response updateAccount(
            @PathParam("id") UUID id,
            @RestForm("account") @PartType(MediaType.APPLICATION_JSON) JsonAccount jsonAccount,
            @RestForm InputStream image) {

        JsonAccount result = accountService.updateAccountById(id, jsonAccount);

        return Response.ok(result).build();
    }

    @DELETE
    @Path("/{id}")
    public Response deleteAccount(@PathParam("id") UUID id) {
        accountService.deleteAccountById(id);
        return Response.noContent().build();
    }

    @POST
    @Path("/{accountId}/homes/{homeId}")
    public Response addHomeToAccount(@PathParam("accountId") UUID accountId, @PathParam("homeId") UUID homeId) {
        accountService.addHomeToAccount(accountId, homeId);
        return Response.ok().build();
    }
}
