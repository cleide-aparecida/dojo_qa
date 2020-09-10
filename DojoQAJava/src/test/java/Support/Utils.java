package Support;

import io.restassured.http.ContentType;
import org.apache.commons.io.IOUtils;
import org.json.JSONObject;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.util.Map;

import static io.restassured.RestAssured.given;

public class Utils extends Base{
    public JSONObject getJson(String jsonPath) throws IOException {
        File file =  new File(jsonPath);
        FileInputStream inputStream = new FileInputStream(file);

        JSONObject payload = new JSONObject(IOUtils.toString(inputStream,"UTF-8"));

        return payload;
    }

    public void cadastrarCorrentista(String cpf, String name, String zipCode, String street, int number,
                                     String birthDate, String accountType){
        JSONObject payload = new JSONObject();
        JSONObject holder = new JSONObject();
        JSONObject address = new JSONObject();

        payload.put("holder", holder.put("cpf",cpf));
        payload.put("holder", holder.put("name",name));
        payload.put("holder", holder.put("birthDate",birthDate));
        payload.put("holder", holder.put("accountType",accountType));
        payload.put("holder", holder.put("address",address.put("zipCode",zipCode)));
        payload.put("holder", holder.put("address",address.put("street",street)));
        payload.put("holder", holder.put("address",address.put("number",number)));

        given().contentType(ContentType.JSON).body(payload.toString()).log().all()
                .when().post("/holders").then().log().all();
    }
}
