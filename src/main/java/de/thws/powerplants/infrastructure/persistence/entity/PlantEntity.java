package de.thws.powerplants.infrastructure.persistence.entity;

import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;

public class PlantEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long id;

    private String publicName;

    private String scientificName;

    private String description;

    private String picture;

}
