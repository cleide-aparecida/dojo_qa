package Support;

import org.apache.commons.io.IOUtils;
import org.json.JSONObject;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.util.Map;

public class Utils {
    public JSONObject getJson(String jsonPath) throws IOException {
        File file =  new File(jsonPath);
        FileInputStream inputStream = new FileInputStream(file);

        JSONObject payload = new JSONObject(IOUtils.toString(inputStream,"UTF-8"));

        return payload;
    }
}
