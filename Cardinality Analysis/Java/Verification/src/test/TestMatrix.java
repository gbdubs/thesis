package test;
import static org.junit.Assert.*;

import org.junit.Test;

import Verification.DimensionMismatchException;
import Verification.Matrix;


public class TestMatrix {

	@Test
	public void testIsZero(){
		int[][] a = {{0,0,0,0,0,0},{0,0,0,0,0,0},{0,0,0,-1,0,0},{0,0,0,0,0,0}};
		int[][] b = {{0,0,0,0,0,0},{0,0,0,0,0,0},{0,0,0,0,0,0},{0,0,0,0,0,0}};
		Matrix A = new Matrix(a);
		Matrix B = new Matrix(b);
		assertFalse(A.isZero());
		assertTrue(B.isZero());
	}
	
	@Test
	public void testEquals(){
		int[][] a = {{0,0,0,0,0,0},{0,0,0,0,0,0},{0,0,0,-1,0,0},{0,0,0,0,0,0}};
		int[][] b = {{0,0,0,0,0,0},{0,1,0,0,0,0},{0,0,0,0,0,0},{0,0,0,0,0,0}};
		int[][] c = {{0,0,0,0,0,0},{0,0,0,0,0,0},{0,0,0,0,0,0},{0,0,0,0,0,0}};
		Matrix A = new Matrix(a);
		Matrix B = new Matrix(b);
		Matrix C = new Matrix(c);
		assertTrue(A.equals(A));
		assertTrue(B.equals(B));
		assertTrue(C.equals(C));
		assertFalse(A.equals(B));
		assertFalse(B.equals(C));
		assertFalse(C.equals(A));
		Matrix AA = new Matrix(a);
		Matrix BB = new Matrix(b);
		Matrix CC = new Matrix(c);
		assertTrue(A.equals(AA));
		assertTrue(B.equals(BB));
		assertTrue(C.equals(CC));
	}
	
	@Test
	public void testSubtract(){
		int[][] a = {{0,0,0,0,0,0},{0,0,0,0,0,0},{0,0,0,-1,0,0},{0,0,0,0,0,0}};
		int[][] b = {{0,0,0,0,0,0},{0,1,0,0,0,0},{0,0,0,0,0,0},{0,0,0,0,0,0}};
		int[][] c = {{0,0,0,0,0,0},{0,0,0,0,0,0},{0,0,0,0,0,0},{0,0,0,0,0,0}};
		Matrix A = new Matrix(a);
		Matrix B = new Matrix(b);
		Matrix C = new Matrix(c);
		try {
			Matrix D = A.subtract(B);
			Matrix E = B.subtract(A);
			assertFalse(D.equals(E));
		} catch (DimensionMismatchException e) {
			assertTrue(false);
		}
		try {
			Matrix D = B.subtract(C);
			assertTrue(D.equals(B));
		} catch (DimensionMismatchException e) {
			assertTrue(false);
		}
		try {
			Matrix D = A.subtract(A);
			assertTrue(D.equals(C));
		} catch (DimensionMismatchException e) {
			assertTrue(false);
		}
	}
	
	@Test
	public void testMultiply(){
		int[][] a = {{1,2,3},{4,5,6}};
		int[][] b = {{0,1,2,3},{4,5,6,9},{7,4,0,1}};
		int[][] c = {{29, 23, 14, 24},{62,53,38,63}};
		Matrix A = new Matrix(a);
		Matrix B = new Matrix(b);
		Matrix C = new Matrix(c);
		try {
			assertEquals(C, A.multiply(B));
		} catch (DimensionMismatchException e) {
			assertTrue(false);
		}
	}
}
