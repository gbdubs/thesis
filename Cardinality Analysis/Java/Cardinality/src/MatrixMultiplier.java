import java.util.Arrays;
import java.util.Comparator;
import java.util.HashSet;
import java.util.Set;
import java.util.TreeSet;


public class MatrixMultiplier {

	private static final int N = 8;
	private static final int X = (N * (N - 1)) / 2;
	private static final int P = N;
	private static final long MAX = (int) Math.pow(2, X);
	
	private static long startTime;
	private static long lastUpdate;
	
	public static void main(String[] args){
		runCardinalityAnalysis();
	}
	
	public static void runCardinalityAnalysis(){
		Set<long[][]> allResults = new TreeSet<long[][]>(new ResultComparator());
		startTime = System.currentTimeMillis();
		for (int i = 0; i < getMaxId(); i++){
			updateUserOnProgress(i);
			long[][] matrix = generateMatrixWithId(i);
			long[][] diagonals = getDiagonalVectors(matrix);
			sortVectors(diagonals);
			allResults.add(diagonals);
		}

		System.out.println("TOTAL CARDINALITY: "+ allResults.size() + ", TOTAL COMPUTE TIME: " + (System.currentTimeMillis() - startTime) + "ms");
	}

	private static void updateUserOnProgress(int i){
		if (i % 10000 == 0){
			if (System.currentTimeMillis() - lastUpdate > 1000){
				double percentDone = ((int) (i * 1000.0 / MAX)) / 10.0;
				int timeGone = (int) (System.currentTimeMillis() - startTime);
				double timeRemaining = ((int) (10 * timeGone * (100 - percentDone) / (1000.0 * (percentDone)))) / 10.0;
				System.out.println(percentDone + "% Done. Estimated " + timeRemaining + " seconds remaining. i is at " + i + ".");
				lastUpdate = System.currentTimeMillis();
			}
		}
	}

	private static void sortVectors(long[][] a){
		boolean madeSwap = true;
		while (madeSwap){
			madeSwap = false;
			for (int i = 0; i < N-1; i++){
				long[] v1 = a[i];
				long[] v2 = a[i+1];
				if (comparelongArray(v1, v2) == -1){
					a[i] = v2;
					a[i+1] = v1;
					madeSwap = true;
				}
			}
		}
	}

	private static int comparelongArray(long[] a, long[] b){
		for (int i = 0; i < a.length; i++){
			int subResult = Long.compare(a[i], b[i]);
			if (subResult != 0){
				return subResult;
			}
		}
		return 0;
	}

	private static long[][] getDiagonalVectors(long[][] a){
		long[][] result = new long[N][P];

		long[][] runningMatrix = a;

		for (int i = 0; i < P; i++){
			for (int j = 0; j < N; j++){
				result[j][i] = runningMatrix[j][j];
			}
			runningMatrix = multiply(runningMatrix, a);
		}

		return result;
	}


	private static long[][] multiply(long[][] a, long[][] b){
		long[][] result = new long[N][N];
		for (int i = 0; i < N; i++){
			for (int j = 0; j < N; j++){
				long runningTotal = 0;
				for (int k = 0; k < N; k++){
					runningTotal += a[i][k] * b[k][j];
				}
				result[i][j] = runningTotal;
			}
		}
		return result;
	}

	
	private static long[][] generateMatrixWithIdAlt(int n){
		long[][] result = new long[N][N];
		Set<Integer> setToOne = getMatrixOnesFromId(n);
		for (int i : setToOne){
			setLocationToOne(result, i);
		}
		return result;
	}
	
	private static long[][] generateMatrixWithId(int n){
		long[][] result = new long[N][N];
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
		return result;
	}
	
	private static void setLocationToOne(long[][] a, int location){
		int i = 1;
		int offset = N - 1;
		int j = 1;
		while (location > offset){
			location -= offset;
			i++;
			offset--;
		}
		i = i - 1;
		j = location + i;
		a[i][j] = 1L;
		a[j][i] = 1L;
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
	
	private static int getMaxId(){
		return (int) (Math.pow(2, X));
	}
	
	private static class ResultComparator implements Comparator<long[][]>{

		@Override
		public int compare(long[][] a, long[][] b) {
			for (int i = 0; i < a.length; i++){
				int compare = compare(a[i], b[i]);
				if (compare != 0){
					return compare;
				}
			}
			return 0;
		}
		
		private int compare(long[] a, long[] b){
			int lengthComparison = Integer.compare(a.length, b.length);
			if (lengthComparison != 0){
				return lengthComparison;
			}
			
			for(int i = 0; i < a.length; i++){
				int comparison = Long.compare(a[i], b[i]);
				if (comparison != 0){
					return comparison;
				}
			}
			
			return 0;
		}
		
	}

}