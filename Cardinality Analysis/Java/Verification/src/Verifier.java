
public class Verifier {

	private static final int MAX_BIT_LENGTH = 64 * 10 * 10;
	
	public static int testEqualPaths(String gA, String gB) throws DimensionMismatchException{
		Matrix A = new Matrix(Graph6.retrieveGraph(gA));
		Matrix B = new Matrix(Graph6.retrieveGraph(gB));
		
		Matrix runningA = A;
		Matrix runningB = B;
		
		int p = 1;
		
		if (!Matrix.sortedDiagonalEquals(A, B)){
			return p;
		}
		
		while (A.nBits() < MAX_BIT_LENGTH){
			if (!Matrix.sortedDiagonalEquals(runningA, runningB)){
				return p;
			}
			runningA = runningA.multiply(A);
			runningB = runningB.multiply(B);
			p++;
		}
		
		return -1;
	}
	
}
