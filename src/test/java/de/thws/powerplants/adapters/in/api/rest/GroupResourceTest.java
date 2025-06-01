package de.thws.powerplants.adapters.in.api.rest;

import static io.restassured.RestAssured.given;
import static org.hamcrest.Matchers.*;
import static org.junit.jupiter.api.Assertions.assertNotNull;

import java.io.*;
import java.util.UUID;

import jakarta.inject.Inject;
import jakarta.transaction.Transactional;

import de.thws.powerplants.adapters.in.api.rest.json.JsonGroup;
import de.thws.powerplants.adapters.out.persistence.jpa.entities.JpaHome;
import de.thws.powerplants.adapters.out.persistence.jpa.repositories.JpaHomeRepository;
import de.thws.powerplants.core.ports.in.ImageServicePortIn;
import io.quarkus.test.common.http.TestHTTPEndpoint;
import io.quarkus.test.junit.QuarkusTest;
import org.junit.jupiter.api.*;

@TestMethodOrder(MethodOrderer.OrderAnnotation.class)
@TestInstance(TestInstance.Lifecycle.PER_CLASS)
@QuarkusTest
@TestHTTPEndpoint(GroupResource.class)
class GroupResourceTest {

    @Inject
    private JpaHomeRepository jpaHomeRepository;

    @Inject
    private ImageServicePortIn imageServicePortIn;

    private UUID homeId;
    private static UUID createdGroupId;

    @BeforeAll
    @Transactional
    void setupHome() {
        JpaHome home = new JpaHome();
        home.setPublicName("Test Home");
        jpaHomeRepository.persist(home);
        homeId = home.getId();
    }

    JsonGroup createTestJsonGroup() {
        JsonGroup group = new JsonGroup();
        group.setPublicName("Test Group");
        group.setDescription("Test description");
        return group;
    }

    @Test
    @Order(1)
    void createGroup() throws IOException {

        InputStream testImage = new FileInputStream("src/test/resources/profile.png");

        JsonGroup jsonGroup = given().multiPart("group", createTestJsonGroup(), "application/json")
                .multiPart("image", "", testImage)
                .pathParam("home_id", homeId)
                .when()
                .post()
                .then()
                .statusCode(201)
                .body("public_name", equalTo("Test Group"))
                .body("description", equalTo("Test description"))
                .extract()
                .jsonPath()
                .getObject("", JsonGroup.class);

        assertNotNull(jsonGroup);

        InputStream image = imageServicePortIn.getImageById(UUID.fromString(jsonGroup.getImageId()));
        assertNotNull(image);
        image.close();

        createdGroupId = jsonGroup.getId();

        assertNotNull(createdGroupId);
    }

    @Test
    @Order(2)
    void getAllGroups() {
        given().pathParam("home_id", homeId)
                .when()
                .get()
                .then()
                .statusCode(200)
                .body("$", not(empty()))
                .body("public_name", hasItem("Test Group"));
    }

    @Test
    @Order(3)
    void getGroupById() {
        given().pathParam("home_id", homeId)
                .pathParam("groupId", createdGroupId)
                .when()
                .get("/{groupId}")
                .then()
                .statusCode(200)
                .body("id", equalTo(createdGroupId.toString()))
                .body("public_name", equalTo("Test Group"));
    }

    @Test
    @Order(4)
    void updateGroupById() {
        JsonGroup updatedGroup = new JsonGroup();
        updatedGroup.setPublicName("Updated Group");
        updatedGroup.setDescription("Updated description");

        InputStream dummyImage = new ByteArrayInputStream("updated-image-content".getBytes());

        given().multiPart("group", updatedGroup, "application/json")
                .multiPart("image", "updated.jpg", dummyImage)
                .pathParam("home_id", homeId)
                .pathParam("groupId", createdGroupId)
                .when()
                .put("/{groupId}")
                .then()
                .statusCode(200)
                .body("public_name", equalTo("Updated Group"))
                .body("description", equalTo("Updated description"));
    }

    @Test
    @Order(5)
    void deleteGroupById() {
        given().pathParam("home_id", homeId)
                .pathParam("groupId", createdGroupId)
                .when()
                .delete("/{groupId}")
                .then()
                .statusCode(204);
    }

    @Test
    @Order(6)
    void getGroupByIdAfterDelete() {
        given().pathParam("home_id", homeId)
                .pathParam("groupId", createdGroupId)
                .when()
                .get("/{groupId}")
                .then()
                .statusCode(404);
    }
}
