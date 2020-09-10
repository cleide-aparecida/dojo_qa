package runners;

import io.cucumber.junit.Cucumber;
import io.cucumber.junit.CucumberOptions;
import org.junit.runner.RunWith;

@RunWith(Cucumber.class)
@CucumberOptions(plugin= {"pretty","html:target/site/cucumber-pretty","json:target/cucumber/cucumber.json"}, features = "src/test/resources/features", glue = {"steps"})
public class RunCucumberTest {

}
