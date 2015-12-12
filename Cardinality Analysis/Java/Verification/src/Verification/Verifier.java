package Verification;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import data.Data;

public class Verifier {

	private static final int MAX_BIT_LENGTH = 600 * 10 * 10;
	
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
			// System.err.println("POWER = "+p+", BITS = "+runningA.nBits());
			p++;
		}
		
		return -1;
	}
	
	private static List<Set<String>> generateCopathsSets(String[] graphs){
		List<Set<String>> sets = new ArrayList<Set<String>>();
		
		for (String graph : graphs){
			boolean found = false;
			for (int i = 0; i < sets.size() && !found; i++){
				Set<String> set = sets.get(i);
				String member = set.iterator().next();
				try {
					if (-1 == testEqualPaths(member, graph)){
						set.add(graph);
						found = true;
					}
				} catch (DimensionMismatchException e) {
					e.printStackTrace();
				}
			}
			if (!found){
				Set<String> newSet = new HashSet<String>();
				newSet.add(graph);
				sets.add(newSet);
			}
			
		}
		
		return sets;
	}
	
	
	public static void main(String[] args){
		for(String name : Data.all.keySet()){
			List<Set<String>> sets = generateCopathsSets(Data.all.get(name));
			System.out.println("\nEQUIVALENCY SETS FOR "+name+": ");
			for (Set<String> set : sets){
				System.out.println(set.toString());
			}
		}
		
		
	}
}
