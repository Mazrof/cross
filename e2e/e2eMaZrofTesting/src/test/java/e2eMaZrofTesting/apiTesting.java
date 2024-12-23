package e2eMaZrofTesting;

import org.junit.jupiter.api.Test;

import static io.restassured.RestAssured.*;

public class apiTesting {

    private static final String BASE_URL = "http://172.20.10.7:3000/api/v1"; // Replace with your API base URI
    private static final String JSON_BODY_LOGIN = "{\n" +
            "    \"email\": \"ma2736666@gmail.com\",\n" +
            "    \"password\": \"Mm#123456\"\n" +
            "}";
    private static final String JSON_BODY_SIGNUP = "{\n" +
            "    \"email\": \"testuser184@example.com\",\n" +
            "    \"username\": \"MohamedAshraf118\",\n" +
            "    \"password\": \"Mm#123456\",\n" +
            "    \"phone\": \"1234567890\"\n" +
            "}";
    
    @Test
    public void testPostApiLogin() throws Exception {
 
        given()
            .baseUri(BASE_URL)
            .header("Content-Type", "application/json")
            .body(JSON_BODY_LOGIN) // Pass the JsonNode as the request body
        .when()
            .post("/auth/login")
        .then()
            .statusCode(200) // Replace with the expected status code
            .log().all(); // Logs the response for debugging
    }
    
    @Test
    public void testPostApiSignUp() throws Exception {
 
        given()
            .baseUri(BASE_URL)
            .header("Content-Type", "application/json")
            .body(JSON_BODY_SIGNUP) // Pass the JsonNode as the request body
        .when()
            .post("/auth/signup")
        .then()
            .statusCode(201) // Replace with the expected status code
            .log().all(); // Logs the response for debugging
    }
}
