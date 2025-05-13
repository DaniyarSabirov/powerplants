package de.thws.powerplants.adapters.in.api;

import de.thws.powerplants.core.domain.Account;
import de.thws.powerplants.core.mappers.AccountMapper;
import de.thws.powerplants.core.services.AccountService;
import jakarta.inject.Inject;
import jakarta.ws.rs.*;
import jakarta.ws.rs.core.MediaType;
import jakarta.ws.rs.core.Response;
import java.util.List;
import java.util.UUID;

@Path("/accounts")
@Produces(MediaType.APPLICATION_JSON)
@Consumes(MediaType.APPLICATION_JSON)
public class AccountResource {

    @Inject
    private AccountService accountService;

    @POST
    public Response createAccount(Account account) {
        accountService.createAccount(account);
        return Response.status(Response.Status.CREATED).build();
    }

    @POST
    @Path("/{accountId}/homes/{homeId}")
    public Response addHomeToAccount(@PathParam("accountId") UUID accountId, @PathParam("homeId") UUID homeId) {
        boolean success = accountService.addHomeToAccount(accountId, homeId);
        if (!success) {
            return Response.status(Response.Status.NOT_FOUND).build();
        }
        return Response.ok().build();
    }

    @GET
    public List<Account> getAllAccounts() {
        return accountService.getAllAccounts();
    }

    @GET
    @Path("/{id}")
    public Response getAccountById(@PathParam("id") UUID id) {
        Account account = accountService.getAccountById(id);
        if (account == null) {
            return Response.status(Response.Status.NOT_FOUND).build();
        }
        return Response.ok(AccountMapper.toJsonAccount(account)).build();
    }

    @PUT
    @Path("/{id}")
    public Response updateAccount(@PathParam("id") UUID id, Account account) {
        boolean updated = accountService.updateAccount(id, account);
        if (!updated) {
            return Response.status(Response.Status.NOT_FOUND).build();
        }
        return Response.ok().build();
    }

    @DELETE
    @Path("/{id}")
    public Response deleteAccount(@PathParam("id") UUID id) {
        boolean deleted = accountService.deleteAccount(id);
        if (!deleted) {
            return Response.status(Response.Status.NOT_FOUND).build();
        }
        return Response.noContent().build();
    }
}
