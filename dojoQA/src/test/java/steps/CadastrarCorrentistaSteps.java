package steps;

import Support.Base;
import Support.Utils;
import io.cucumber.java.pt.*;
import io.restassured.http.ContentType;
import org.json.JSONObject;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import static io.restassured.RestAssured.given;
import static org.hamcrest.CoreMatchers.*;

public class CadastrarCorrentistaSteps extends Base {

    private JSONObject payload;

    @Dado("que os dados para cadastro foram fornecidos")
    public void que_os_dados_para_cadastro_foram_fornecidos_corretamente() throws IOException {
        payload =  new Utils().getJson("src/test/resources/requests/CadastrarCorrentista.json");
        setRequestSpecification(given().contentType(ContentType.JSON).log().all());
    }

    @Dado("que o campo {string} é fornecido como {string}")
    public void que_o_campo_e_fornecido_como(String nomeCampo, String valorCampo) {
        switch (nomeCampo){
            case "zipCode":
                payload.getJSONObject("holder").getJSONObject("address").put(nomeCampo,valorCampo);
                break;
            default:
                payload.getJSONObject("holder").put(nomeCampo,valorCampo);
        }
    }

    @Dado("que o campo {string} não é informado na request")
    public void que_o_campo_não_é_informado_na_request(String nomeCampo) {
        switch (nomeCampo){
            case "zipCode":
                payload.getJSONObject("holder").getJSONObject("address").remove(nomeCampo);
                break;
            case "number":
                payload.getJSONObject("holder").getJSONObject("address").remove(nomeCampo);
                break;
            case "street":
                payload.getJSONObject("holder").getJSONObject("address").remove(nomeCampo);
                break;
            default:
                payload.getJSONObject("holder").remove(nomeCampo);
        }
    }


    @Quando("efetuo a operação de POST no caminho {string}")
    public void efetuo_a_operação_de_post_no_caminho(String resource) {
       setResponse(getRequestSpecification().body(payload.toString()).when().post(resource));
    }

    @Então("o cadastro é realizado com sucesso")
    public void o_cadastro_é_realizado_com_sucesso() {
        setValidatableResponse(getResponse().then().body("holderId", is(notNullValue())));
    }

    @Então("status code {int} é retornado")
    public void status_code_é_retornado(Integer int1) {
        setValidatableResponse(getResponse().then().statusCode(int1));
    }


    @Entao("a mensagem {string} é retornada")
    public void a_mensagem_é_retornada(String message) {
        setValidatableResponse(getResponse().then().body("message", equalTo(message)));
    }

}
