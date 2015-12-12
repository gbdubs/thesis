import org.junit.Test;
import static org.junit.Assert.*;

public class TestVerifier {

	public static void basicTest(String s1, String s2, int expectation){
		try {
			int result = Verifier.testEqualPaths(s1, s2);
			assertEquals(expectation, result);
		} catch (DimensionMismatchException e) {
			assertTrue(false);
		}
	}
	
	@Test
	public void testVerifier(){
		basicTest("G?`c~w", "G?`c~s", 2);
		
		// More test cases to come...
	}
}
