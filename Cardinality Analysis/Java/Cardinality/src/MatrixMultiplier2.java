import java.util.Comparator;
import java.util.HashSet;
import java.util.Set;
import java.util.TreeSet;

import org.jblas.DoubleMatrix;


public class MatrixMultiplier2 {

	private static final int N = 7;
	private static final int X = (N * (N - 1)) / 2;
	private static final int P = N;

	private static final long MAX = (int) Math.pow(2, X);
	private static long startTime;
	private static long lastUpdate;
	
	public static void main(String[] args){
		runCardinalityAnalysis();
	}
	
	public static void runCardinalityAnalysis(){
		Set<double[][]> allResults = new TreeSet<double[][]>(new ResultComparator());
		
		startTime = System.currentTimeMillis();
		
		for (int i = 0; i < MAX; i++){
			updateUserOnProgress(i);
			
			DoubleMatrix matrix = generateMatrixWithId(i);
			double[][] diagonals = getDiagonalVectors(matrix);
			sortVectors(diagonals);
			
			allResults.add(diagonals);
		}

		System.out.println("TOTAL CARDINALITY: "+ allResults.size() + ", TOTAL COMPUTE TIME: " + (System.currentTimeMillis() - startTime) + "ms");
	}


	private static void updateUserOnProgress(int i){
		if (i % 10000 == 0){
			if (System.currentTimeMillis() - lastUpdate > 1000){
				double percentDone = (i * 1000 / MAX) / 10.0;
				int timeGone = (int) (System.currentTimeMillis() - startTime);
				double timeRemaining = ((int) (10 * timeGone * (100 - percentDone) / (1000.0 * (percentDone)))) / 10.0;
				System.out.println(percentDone + "% Done. Estimated " + timeRemaining + " seconds remaining.");
				lastUpdate = System.currentTimeMillis();
			}
		}
	}
	
	private static void sortVectors(double[][] a){
		boolean madeSwap = true;
		while (madeSwap){
			madeSwap = false;
			for (int i = 0; i < N-1; i++){
				double[] v1 = a[i];
				double[] v2 = a[i+1];
				if (compareDoubleArray(v1, v2) == -1){
					a[i] = v2;
					a[i+1] = v1;
					madeSwap = true;
				}
			}
		}
	}

	private static int compareDoubleArray(double[] a, double[] b){
		for (int i = 0; i < a.length; i++){
			int subResult = Double.compare(a[i], b[i]);
			if (subResult != 0){
				return subResult;
			}
		}
		return 0;
	}

	private static double[][] getDiagonalVectors(DoubleMatrix original){
		double[][] result = new double[N][P];

		DoubleMatrix runningMatrix = original.dup();

		for (int i = 0; i < P; i++){
			for (int j = 0; j < N; j++){
				result[j][i] = runningMatrix.get(j, j);
			}
			DoubleMatrix temp = multiply(runningMatrix, original);
			runningMatrix = temp;
		}

		return result;
	}


	private static DoubleMatrix multiply(DoubleMatrix a, DoubleMatrix b){
		return a.mmul(b);
	}
	
	private static DoubleMatrix generateMatrixWithId(int n){
		double[][] result = new double[N][N];
		Set<Integer> setToOne = getMatrixOnesFromId(n);
		int index = 0;
		for (int i = 0; i < N; i++){
			for (int j = i+1; j < N; j++){
				index++;
				if (setToOne.contains(index)){
					result[i][j] = 1L;
					result[j][i] = 1L;
				}
			}
		}
		DoubleMatrix objectNotation = new DoubleMatrix(result);
		return objectNotation;
	}

	private static Set<Integer> getMatrixOnesFromId(int n){
		if (n > Math.pow(2, X)){
			n = n % ((int) Math.pow(2, X));
		}
		int index = X;
		Set<Integer> result = new HashSet<Integer>();
		while (n > 0){
			if (n % 2 == 1){
				result.add(index);
			}
			index--;
			n /= 2;
		}
		return result;
	}
	
	
	private static class ResultComparator implements Comparator<double[][]>{

		@Override
		public int compare(double[][] a, double[][] b) {
			for (int i = 0; i < a.length; i++){
				int compare = compare(a[i], b[i]);
				if (compare != 0){
					return compare;
				}
			}
			return 0;
		}
		
		private int compare(double[] a, double[] b){
			int lengthComparison = Integer.compare(a.length, b.length);
			if (lengthComparison != 0){
				return lengthComparison;
			}
			
			for(int i = 0; i < a.length; i++){
				int comparison = Double.compare(a[i], b[i]);
				if (comparison != 0){
					return comparison;
				}			
			}
			
			return 0;
		}
		
	}

}