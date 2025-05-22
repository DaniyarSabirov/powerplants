package de.thws.powerplants.adapters.out.persistence.entities;

import jakarta.persistence.*;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

@Entity
@Table(name = "home")
public class JpaHome {

    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    @Column(name = "id")
    private UUID id;

    @ManyToMany(mappedBy = "homes")
    private List<JpaAccount> accounts = new ArrayList<>();

    @OneToMany(cascade = CascadeType.ALL, orphanRemoval = true)
    @JoinColumn(name = "home_id")
    private List<JpaGroup> groups = new ArrayList<>();

    @Column(name = "public_name", nullable = false)
    private String publicName;

    @Column(name = "description")
    private String description;

    public JpaHome() {}

    public UUID getId() {
        return id;
    }

    public void setId(UUID id) {
        this.id = id;
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
}
