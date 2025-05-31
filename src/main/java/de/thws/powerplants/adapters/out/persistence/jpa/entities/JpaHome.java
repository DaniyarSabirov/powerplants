package de.thws.powerplants.adapters.out.persistence.jpa.entities;

import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import jakarta.persistence.*;

@Entity
@Table(name = "home")
public class JpaHome {

    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    @Column(name = "id")
    private UUID id;

    @Column(name = "public_name", nullable = false)
    private String publicName;

    @Column(name = "description")
    private String description;

    @ManyToMany(mappedBy = "homes")
    private List<JpaAccount> accounts = new ArrayList<>();

    @OneToMany(mappedBy = "home", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<JpaGroup> groups = new ArrayList<>();

    public JpaHome() {}

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

    public List<JpaAccount> getAccounts() {
        return accounts;
    }

    public void setAccounts(List<JpaAccount> accounts) {
        this.accounts = accounts;
    }

    public List<JpaGroup> getGroups() {
        return groups;
    }

    public void setGroups(List<JpaGroup> groups) {
        this.groups = groups;
    }
}
