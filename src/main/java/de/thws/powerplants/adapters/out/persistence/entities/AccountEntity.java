package de.thws.powerplants.adapters.out.persistence.entities;

import jakarta.persistence.*;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

@Entity
@Table(name = "account")
public class AccountEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    @Column(name = "id")
    private UUID id;

    @ManyToMany
    @JoinTable(
            name = "account_home",
            joinColumns = @JoinColumn(name = "home_id"),
            inverseJoinColumns = @JoinColumn(name = "account_id"))
    private List<HomeEntity> homes = new ArrayList<>();

    @Column(name = "public_name", nullable = false)
    private String publicName;

    @Column(name = "login_name", nullable = false)
    private String name;

    @Column(name = "login_password", nullable = false)
    private String password;

    @Column(name = "picture_url")
    private String pictureUrl;

    public AccountEntity() {}

    public UUID getId() {
        return id;
    }

    public void setId(UUID id) {
        this.id = id;
    }

    public List<HomeEntity> getHomes() {
        return homes;
    }

    public void setHomes(List<HomeEntity> homes) {
        this.homes = homes;
    }

    public String getPublicName() {
        return publicName;
    }

    public void setPublicName(String publicName) {
        this.publicName = publicName;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getPictureUrl() {
        return pictureUrl;
    }

    public void setPictureUrl(String pictureUrl) {
        this.pictureUrl = pictureUrl;
    }
}
