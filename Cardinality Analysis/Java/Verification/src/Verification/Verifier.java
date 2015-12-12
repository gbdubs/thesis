package Verification;

import java.math.BigInteger;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import data.Data;

public class Verifier {

	private static final int MAX_BIT_LENGTH = 1000 * 10 * 10;
	
	public static int testEqualPaths(String gA, String gB) throws DimensionMismatchException{
		Matrix A = new Matrix(Graph6.retrieveGraph(gA));
		Matrix B = new Matrix(Graph6.retrieveGraph(gB));
		
		Matrix runningA = A;
		Matrix runningB = B;
		
		int p = 1;
		
		Map<Integer, List<BigInteger>> vectorsA = new HashMap<Integer, List<BigInteger>>();
		Map<Integer, List<BigInteger>> vectorsB = new HashMap<Integer, List<BigInteger>>();
		
		for (int i = 0; i < A.x; i++){
			List<BigInteger> lbiA = new ArrayList<BigInteger>();
			lbiA.add(runningA.values[i][i]);
			vectorsA.put(i, lbiA);
			List<BigInteger> lbiB = new ArrayList<BigInteger>();
			lbiB.add(runningB.values[i][i]);
			vectorsB.put(i, lbiB);
		}
		
		while (runningA.nBits() < MAX_BIT_LENGTH){
			runningA = runningA.multiply(A);
			runningB = runningB.multiply(B);
			
			for (int i = 0; i < A.x; i++){
				vectorsA.get(i).add(runningA.values[i][i]);
				vectorsB.get(i).add(runningB.values[i][i]);
			}
			
			if (compare(vectorsA.values(), vectorsB.values()) != 0){
				return p;
			}
			
			p++;
		}
		
		return -1;
	}
	
	public static int compare(Collection<List<BigInteger>> a, Collection<List<BigInteger>> b){
		List<List<BigInteger>> A = new ArrayList<List<BigInteger>>(a);
		List<List<BigInteger>> B = new ArrayList<List<BigInteger>>(b);
		ListComparator lc = new ListComparator();
		Collections.sort(A, lc);
		Collections.sort(B, lc);
		for (int i = 0; i < A.size(); i++){
			int comparison = lc.compare(A.get(i), B.get(i));
			if (comparison != 0){
				return comparison;
			}
		}
		return 0;
	}
	
	private static class ListComparator implements Comparator<List<BigInteger>>{

		@Override
		public int compare(List<BigInteger> o1, List<BigInteger> o2) {
			int sizeComparison = Integer.compare(o1.size(), o2.size());
			if (sizeComparison != 0){
				return sizeComparison;
			}
			
			for (int i = 0; i < o1.size(); i++){
				int comparison = o1.get(i).compareTo(o2.get(i));
				if (comparison != 0){
					return comparison;
				}
			}
			return 0;
		}
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
