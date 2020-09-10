package steps;


import Support.Base;
import Support.Utils;
import io.cucumber.java.pt.*;
import io.restassured.http.ContentType;
import org.json.JSONObject;

import java.io.IOException;
import java.util.Random;

import static io.restassured.RestAssured.given;
import static org.hamcrest.CoreMatchers.*;


public class ConsultarEnderecoCorrentistaSteps extends Base{

    private String cpf;
    private String accountType = "PF";

    @Dado("que já possuo {int} correntistas cadastrados no sistema")
    public void que_já_possuo_correntistas_cadastrados_no_sistema(int numeroCorrentistas) throws IOException {
        Utils utils = new Utils();
        for(int i = 0; i < numeroCorrentistas; i++){
            long cpfNumber = 10000000000L + new Random().nextInt(900000000);
            int zipCodeNumber = 1000000 + new Random().nextInt(90000000);
            int number = 1000000 + new Random().nextInt(90000000);
            cpf = String.valueOf(cpfNumber);
            String name = "Cleide_" + zipCodeNumber;
            String zipCode = String.valueOf(zipCodeNumber);
            String street = "Rua das flores_" + number;
            String birthDate = "1987-05-25";
            utils.cadastrarCorrentista(cpf,name,zipCode,street,number,birthDate,accountType);
        }
        setRequestSpecification(given().contentType(ContentType.JSON).log().all());
    }

    @Dado("que possuo as informações de CFP valido")
    public void que_possuo_as_informações_de_cfp() {
        setRequestSpecification(getRequestSpecification().queryParam("cpf",cpf));
    }

    @Dado("tipo da conta do correntista")
    public void tipo_da_conta_do_correntista() {
        setRequestSpecification(getRequestSpecification().queryParam("accountType", accountType));

    }

    @Então("o endereço correto do correntista é retornado")
    public void o_endereço_correto_do_correntista_é_retornado() {
        setValidatableResponse(getResponse().then().log().all().body("address",is(notNullValue())));
    }

    @Então("a mensagem {string} é retornada na consulta")
    public void a_mensagem_é_retornada_na_consulta(String message) {
        setValidatableResponse(getResponse().then().body("message", equalTo(message)).log().all());
    }

    @Dado("que possuo a informação de cpf como sendo {string}")
    public void que_possuo_a_informação_de_cpf_como_sendo(String cpf) {
        setRequestSpecification(getRequestSpecification().queryParam("cpf",cpf));
    }

    @Dado("não possuo o tipo de conta do correntista")
    public void não_possuo_o_tipo_de_conta_do_correntista() {
        //setRequestSpecification(getRequestSpecification());
    }

    @Dado("que possuo a informação de tipo de conta como sendo {string}")
    public void que_possuo_a_informação_de_tipo_de_conta_como_sendo(String accountType) {
        setRequestSpecification(getRequestSpecification().queryParam("accountType", accountType));
    }

    @Dado("não possuo o cpf do correntista")
    public void não_possuo_o_cpf_do_correntista() {
        //setRequestSpecification(getRequestSpecification());
    }

    @Dado("que possuo um CFP valido que não esta cadastrado no sistema")
    public void que_não_esta_cadastrado_no_sistema() {
        setRequestSpecification(getRequestSpecification().queryParam("cpf","00000000000"));
    }

    @Dado("um tipo da conta valida do correntista")
    public void um_tipo_da_conta_valida_do_correntista() {
        setRequestSpecification(getRequestSpecification().queryParam("accountType", accountType));
    }

    @Dado("tipo de conta do correntista sendo XT")
    public void tipo_de_conta_do_correntista_sendo_xt() {
        setRequestSpecification(getRequestSpecification().queryParam("accountType", "XT"));
    }

    @Quando("efetuo a consulta de endereço")
    public void efetuo_a_consulta_de_endereço() {
        setResponse(getRequestSpecification().when().get("/holders/address"));
    }

    @Dado("que possuo a informação de CPF diferente de onze digitos")
    public void que_possuo_a_informação_de_cpf_diferente_de_digitos() {
        setRequestSpecification(getRequestSpecification().queryParam("cpf","1234"));
    }


}
