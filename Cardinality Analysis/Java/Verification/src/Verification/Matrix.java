package Verification;
import java.math.BigInteger;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;


public class Matrix {

	BigInteger[][] values;
	int x;
	int y;
	
	private Matrix(int x, int y){
		this.x = x;
		this.y = y;
		this.values = new BigInteger[y][x];
	}
	
	public Matrix(int[][] vals){
		values = new BigInteger[vals.length][vals[0].length];
		for (int i = 0; i < vals.length; i++){
			for (int j = 0; j < vals[0].length; j++){
				values[i][j] = BigInteger.valueOf((long) vals[i][j]);
			}
		}
		x = vals[0].length;
		y = vals.length;
	}
	
	public static Matrix multiply(Matrix a, Matrix b) throws DimensionMismatchException{
		if (a.x != b.y){
			System.err.format("DIMENSION MULTIPLICATION MISMATCH! a=[%dx%d] b=[%dx%d]", a.x, a.y, b.x, b.y);
			throw new DimensionMismatchException("Dismension Mismatch DimensionMismatchException (MULT)");
		}		
		Matrix c = new Matrix(b.x, a.y);
		for (int i = 0; i < a.y; i++){
			for (int j = 0; j < b.x; j++){
				c.values[i][j] = BigInteger.ZERO;
				for (int k = 0; k < a.x; k++){
					c.values[i][j] = c.values[i][j].add(a.values[i][k].multiply(b.values[k][j]));
				}
			}
		}
		return c;
	}
	
	public Matrix multiply(Matrix o) throws DimensionMismatchException{
		return multiply(this, o);
	}
	
	public static Matrix subtract(Matrix a, Matrix b) throws DimensionMismatchException{
		if (a.x != b.x || a.y != b.y){
			System.err.format("DIMENSION SUBTRACTION MISMATCH! a=[%dx%d] b=[%dx%d]", a.x, a.y, b.x, b.y);
			throw new DimensionMismatchException("Dismension Mismatch DimensionMismatchException (SUB)");
		}
		Matrix c = new Matrix(a.x, a.y);
		for (int i = 0; i < a.y; i++){
			for (int j = 0; j < a.x; j++){
				c.values[i][j] = a.values[i][j].subtract(b.values[i][j]);
			}
		}
		return c;
	}
	
	public Matrix subtract(Matrix o) throws DimensionMismatchException{
		return subtract(this, o);
	}
	
	public static boolean equals(Matrix a, Matrix b){
		if (a.x != b.x || a.y != b.y){
			return false;
		}
		
		for (int i = 0; i < a.y; i++){
			for (int j = 0; j < a.x; j++){
				if (!a.values[i][j].subtract(b.values[i][j]).equals(BigInteger.ZERO)){
					return false;
				}
			}
		}
		return true;
	}
	
	public boolean equals(Object o){
		if (o instanceof Matrix){
			return equals(this, (Matrix) o);
		}
		return false;
	}
	
	public static boolean sortedDiagonalEquals(Matrix a, Matrix b) throws DimensionMismatchException{
		if (a.x != b.x || a.y != b.y){
			System.err.format("DIMENSION MISMATCH! DIAGONAL! a=[%dx%d] b=[%dx%d]", a.x, a.y, b.x, b.y);
			throw new DimensionMismatchException("Dismension Mismatch Exception (DIAG)");
		}
		
		List<BigInteger> tl = new ArrayList<BigInteger>();
		List<BigInteger> ol = new ArrayList<BigInteger>();
		for (int i = 0; i < Math.min(a.x, a.y); i++){
			tl.add(a.values[i][i]);
			ol.add(b.values[i][i]);
		}
		Collections.sort(tl);
		Collections.sort(ol);
		for (int i = 0; i < tl.size(); i++){
			if (!tl.get(i).subtract(ol.get(i)).equals(BigInteger.ZERO)){
				return false;
			}
		}
		return true;
	}

	public boolean sortedDiagonalEquals(Matrix o) throws DimensionMismatchException{
		return sortedDiagonalEquals(this, o);
	}

	public boolean isZero(){
		for (int i = 0; i < y; i++){
			for (int j = 0; j < x; j++){
				if (!values[i][j].equals(BigInteger.ZERO)){
					return false;
				}
			}
		}
		return true;
	}
	
	public int nBits(){
		int nBits = 0;
		for (int i = 0; i < y; i++){
			for (int j = 0; j < x; j++){
				nBits += values[i][j].bitCount();
			}
		}
		return nBits;
	}
}
