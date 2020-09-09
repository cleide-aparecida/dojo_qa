package Support;

import io.restassured.RestAssured;
import io.restassured.response.Response;
import io.restassured.response.ValidatableResponse;
import io.restassured.specification.RequestSpecification;

public class Base {

    private Response response;
    private ValidatableResponse validatableResponse;
    private RequestSpecification requestSpecification;

    public Base(){
        RestAssured.baseURI = "http://localhost:8181/api/v1";
    }

    public Response getResponse() {
        return response;
    }

    public void setResponse(Response response) {
        this.response = response;
    }

    public ValidatableResponse getValidatableResponse() {
        return validatableResponse;
    }

    public void setValidatableResponse(ValidatableResponse validatableResponse) {
        this.validatableResponse = validatableResponse;
    }

    public RequestSpecification getRequestSpecification() {
        return requestSpecification;
    }

    public void setRequestSpecification(RequestSpecification requestSpecification) {
        this.requestSpecification = requestSpecification;
    }

}
