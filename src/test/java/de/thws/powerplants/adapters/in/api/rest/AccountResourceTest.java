package de.thws.powerplants.adapters.in.api.rest;

import static io.restassured.RestAssured.given;
import static org.junit.jupiter.api.Assertions.*;

import java.io.InputStream;

import de.thws.powerplants.adapters.in.api.rest.json.JsonAccount;
import io.quarkus.test.common.http.TestHTTPEndpoint;
import io.quarkus.test.junit.QuarkusTest;
import org.junit.jupiter.api.MethodOrderer;
import org.junit.jupiter.api.Order;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.TestMethodOrder;

@TestMethodOrder(MethodOrderer.OrderAnnotation.class)
@QuarkusTest
@TestHTTPEndpoint(AccountResource.class)
class AccountResourceTest {

    JsonAccount createTestJsonAccount() {

        JsonAccount jsonAccount = new JsonAccount();

        jsonAccount.setLoginName("test");
        jsonAccount.setLoginPassword("test");
        jsonAccount.setPublicName("test");

        return jsonAccount;
    }

    InputStream createTestImageInputStream() {
        return InputStream.nullInputStream();
    }

    @Test
    @Order(1)
    void createAccount() {
        given().multiPart("account", createTestJsonAccount())
                // .multiPart("image", createTestImageInputStream())
                .when()
                .post()
                .then()
                .statusCode(201);
    }

    @Test
    @Order(2)
    void getAccounts() {
        given().when().get().then().statusCode(200);
    }

    @Test
    @Order(3)
    void getAccountById() {}

    @Test
    @Order(4)
    void updateAccount() {}

    @Test
    @Order(5)
    void deleteAccount() {}

    @Test
    @Order(6)
    void addHomeToAccount() {}
}
