package de.thws.powerplants.adapters.in.api.rest.json;

import java.util.List;
import java.util.UUID;

import com.fasterxml.jackson.databind.PropertyNamingStrategies;
import com.fasterxml.jackson.databind.annotation.JsonNaming;

@JsonNaming(PropertyNamingStrategies.SnakeCaseStrategy.class)
public class JsonHome {

    private UUID id;
    private String publicName;
    private String description;

    private List<JsonAccount> accounts;
    private List<JsonGroup> groups;

    public JsonHome() {}

    public UUID getId() {
        return id;
    }

    public void setId(UUID id) {
        this.id = id;
    }

    public String getPublicName() {
        return publicName;
    }

    public void setPublicName(String publicName) {
        this.publicName = publicName;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public List<JsonAccount> getAccounts() {
        return accounts;
    }

    public void setAccounts(List<JsonAccount> accounts) {
        this.accounts = accounts;
    }

    public List<JsonGroup> getGroups() {
        return groups;
    }

    public void setGroups(List<JsonGroup> groups) {
        this.groups = groups;
    }
}
