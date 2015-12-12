package Verification;

import data.Data;

public class Verifier {

	private static final int MAX_BIT_LENGTH = 6400 * 10 * 10;
	
	public static int testEqualPaths(String gA, String gB) throws DimensionMismatchException{
		Matrix A = new Matrix(Graph6.retrieveGraph(gA));
		Matrix B = new Matrix(Graph6.retrieveGraph(gB));
		
		Matrix runningA = A;
		Matrix runningB = B;
		
		int p = 1;
		
		if (!Matrix.sortedDiagonalEquals(A, B)){
			return p;
		}
		
		while (runningA.nBits() < MAX_BIT_LENGTH){
			if (!Matrix.sortedDiagonalEquals(runningA, runningB)){
				return p;
			}
			runningA = runningA.multiply(A);
			runningB = runningB.multiply(B);
			System.err.println("POWER = "+p+", BITS = "+runningA.nBits());
			p++;
		}
		
		return -1;
	}
	
	
	public static void main(String[] args){
		try {
			int result = testEqualPaths(Data.v10e17[0], Data.v10e17[1]);
			System.out.println(result);
		} catch (DimensionMismatchException e) {
			e.printStackTrace();
		}
		
		
	}
}
