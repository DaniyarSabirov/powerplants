package de.thws.powerplants.adapters.in.api.rest;

import static io.restassured.RestAssured.given;
import static org.hamcrest.Matchers.*;
import static org.junit.jupiter.api.Assertions.assertNotNull;

import java.util.UUID;

import de.thws.powerplants.adapters.in.api.rest.json.JsonHome;
import de.thws.powerplants.test.S3MockTestResource;
import io.quarkus.test.common.QuarkusTestResource;
import io.quarkus.test.common.http.TestHTTPEndpoint;
import io.quarkus.test.junit.QuarkusTest;
import org.junit.jupiter.api.MethodOrderer;
import org.junit.jupiter.api.Order;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.TestMethodOrder;

@TestMethodOrder(MethodOrderer.OrderAnnotation.class)
@QuarkusTest
@QuarkusTestResource(S3MockTestResource.class)
@TestHTTPEndpoint(HomeResource.class)
class HomeResourceTest {

    JsonHome createTestJsonHome() {
        JsonHome home = new JsonHome();
        home.setPublicName("Test Home");
        home.setDescription("Description for test home");
        return home;
    }

    private static UUID createdHomeId;

    @Test
    @Order(1)
    void createHome() {
        createdHomeId = given().contentType("application/json")
                .body(createTestJsonHome())
                .when()
                .post()
                .then()
                .statusCode(201)
                .body("public_name", equalTo("Test Home"))
                .body("description", equalTo("Description for test home"))
                .extract()
                .jsonPath()
                .getObject("id", UUID.class);

        assertNotNull(createdHomeId);
    }

    @Test
    @Order(2)
    void getHomes() {
        given().when().get().then().statusCode(200).body("$", not(empty()));
    }

    @Test
    @Order(3)
    void getHomeById() {
        given().pathParam("id", createdHomeId)
                .when()
                .get("/{id}")
                .then()
                .statusCode(200)
                .body("id", equalTo(createdHomeId.toString()))
                .body("public_name", equalTo("Test Home"));
    }

    @Test
    @Order(4)
    void updateHome() {
        JsonHome updatedHome = new JsonHome();
        updatedHome.setPublicName("Updated Home");
        updatedHome.setDescription("Updated description");

        given().contentType("application/json")
                .pathParam("id", createdHomeId)
                .body(updatedHome)
                .when()
                .put("/{id}")
                .then()
                .statusCode(200)
                .body("public_name", equalTo("Updated Home"))
                .body("description", equalTo("Updated description"));
    }

    @Test
    @Order(5)
    void deleteHome() {
        given().pathParam("id", createdHomeId).when().delete("/{id}").then().statusCode(204);
    }

    @Test
    @Order(6)
    void getHomeByIdAfterDelete() {
        given().pathParam("id", createdHomeId).when().get("/{id}").then().statusCode(404);
    }
}
