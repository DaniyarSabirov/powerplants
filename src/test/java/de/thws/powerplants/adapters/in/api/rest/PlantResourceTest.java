package de.thws.powerplants.adapters.in.api.rest;

import static io.restassured.RestAssured.given;
import static org.hamcrest.Matchers.*;
import static org.junit.jupiter.api.Assertions.assertNotNull;

import java.io.ByteArrayInputStream;
import java.io.InputStream;
import java.util.UUID;

import de.thws.powerplants.adapters.in.api.rest.json.JsonPlant;
import de.thws.powerplants.adapters.out.persistence.jpa.entities.JpaGroup;
import de.thws.powerplants.adapters.out.persistence.jpa.repositories.JpaGroupRepository;
import io.quarkus.test.common.http.TestHTTPEndpoint;
import io.quarkus.test.junit.QuarkusTest;

import jakarta.inject.Inject;
import jakarta.transaction.Transactional;

import org.junit.jupiter.api.*;

@TestMethodOrder(MethodOrderer.OrderAnnotation.class)
@TestInstance(TestInstance.Lifecycle.PER_CLASS)
@QuarkusTest
@TestHTTPEndpoint(PlantResource.class)
class PlantResourceTest {

    @Inject
    JpaGroupRepository jpaGroupRepository;

    private UUID groupId;
    private static UUID createdPlantId;

    @BeforeAll
    @Transactional
    void setupGroup() {
        JpaGroup group = new JpaGroup();
        group.setPublicName("Test Group");
        jpaGroupRepository.persist(group);
        groupId = group.getId();
    }

    JsonPlant createTestJsonPlant() {
        JsonPlant plant = new JsonPlant();
        plant.setPublicName("Test Plant");
        plant.setScientificName("Testus Plantus");
        plant.setDescription("A test description");
        return plant;
    }

    @Test
    @Order(1)
    void createPlant() {
        createdPlantId = given()
                .multiPart("plant", createTestJsonPlant(), "application/json")
                .pathParam("group_id", groupId)
                .when()
                .post()
                .then()
                .statusCode(201)
                .body("public_name", equalTo("Test Plant"))
                .extract()
                .jsonPath()
                .getObject("id", UUID.class);

        assertNotNull(createdPlantId);
    }

    @Test
    @Order(2)
    void getAllPlants() {
        given()
                .pathParam("group_id", groupId)
                .when()
                .get()
                .then()
                .statusCode(200)
                .body("$", not(empty()));
    }

    @Test
    @Order(3)
    void getPlantById() {
        given()
                .pathParam("group_id", groupId)
                .pathParam("plantId", createdPlantId)
                .when()
                .get("/{plantId}")
                .then()
                .statusCode(200)
                .body("id", equalTo(createdPlantId.toString()))
                .body("public_name", equalTo("Test Plant"));
    }

    @Test
    @Order(4)
    void updatePlantById() {
        JsonPlant updatedPlant = new JsonPlant();
        updatedPlant.setPublicName("Updated Plant");
        updatedPlant.setScientificName("Updatedus Plantus");
        updatedPlant.setDescription("Updated description");

        InputStream dummyImage = new ByteArrayInputStream("updated-image".getBytes());

        given()
                .multiPart("plant", updatedPlant, "application/json")
                .multiPart("image", "updated.jpg", dummyImage)
                .pathParam("group_id", groupId)
                .pathParam("plantId", createdPlantId)
                .when()
                .put("/{plantId}")
                .then()
                .statusCode(200)
                .body("public_name", equalTo("Updated Plant"))
                .body("description", equalTo("Updated description"));
    }

    @Test
    @Order(5)
    void deletePlant() {
        given()
                .pathParam("group_id", groupId)
                .pathParam("plantId", createdPlantId)
                .when()
                .delete("/{plantId}")
                .then()
                .statusCode(204);
    }

    @Test
    @Order(6)
    void getPlantByIdAfterDelete() {
        given()
                .pathParam("group_id", groupId)
                .pathParam("plantId", createdPlantId)
                .when()
                .get("/{plantId}")
                .then()
                .statusCode(404);
    }
}
