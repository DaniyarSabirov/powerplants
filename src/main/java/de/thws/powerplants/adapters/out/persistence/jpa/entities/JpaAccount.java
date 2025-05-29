package de.thws.powerplants.adapters.out.persistence.jpa.entities;

import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import jakarta.persistence.*;

@Entity
@Table(name = "account")
public class JpaAccount {

    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    @Column(name = "id")
    private UUID id;

    @Column(name = "public_name", nullable = false)
    private String publicName;

    @Column(name = "login_name", nullable = false)
    private String loginName;

    @Column(name = "login_password", nullable = false)
    private String loginPassword;

    @Column(name = "image_id")
    private String imageId;

    @ManyToMany
    @JoinTable(
            name = "account_home",
            joinColumns = @JoinColumn(name = "home_id"),
            inverseJoinColumns = @JoinColumn(name = "account_id"))
    private List<JpaHome> homes = new ArrayList<>();

    public JpaAccount() {}

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

    public String getLoginName() {
        return loginName;
    }

    public void setLoginName(String loginName) {
        this.loginName = loginName;
    }

    public String getLoginPassword() {
        return loginPassword;
    }

    public void setLoginPassword(String loginPassword) {
        this.loginPassword = loginPassword;
    }

    public String getImageId() {
        return imageId;
    }

    public void setImageId(String imageId) {
        this.imageId = imageId;
    }

    public List<JpaHome> getHomes() {
        return homes;
    }

    public void setHomes(List<JpaHome> homes) {
        this.homes = homes;
    }
}
