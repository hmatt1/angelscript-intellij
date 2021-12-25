import com.intellij.testFramework.fixtures.BasePlatformTestCase;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.params.ParameterizedTest;
import org.junit.jupiter.params.provider.CsvFileSource;
import org.junit.runner.RunWith;

import static org.assertj.core.api.AssertionsForClassTypes.assertThat;

@RunWith(com.intellij.testFramework.Parameterized.class)
public class AngelScriptParserOPTest extends BasePlatformTestCase {

    @BeforeEach
    public void setup() throws Exception {
        super.setUp();
    }

    @ParameterizedTest
    @CsvFileSource(resources = "ops.csv")
    public void testScriptsParse(String fileName) {
        myFixture.configureByFile(fileName);
        assertThat(myFixture.checkHighlighting()).isGreaterThan(0L);
    }

    @AfterEach
    public void tearDown() throws Exception {
        super.tearDown();
    }

    @Override
    protected String getTestDataPath() {
        return "src/test/testData/opscripts";
    }

}
