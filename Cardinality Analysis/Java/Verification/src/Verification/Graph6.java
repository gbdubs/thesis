package Verification;

import java.util.Arrays;

public class Graph6 {

	/*
	 * Converts a string in Graph6 format to an adjacency
	 * matrix for manipulation.
	 * 1) Remove the first character from s (it tells you v), calculate e.
	 * 2) For each character, subtract 63, convert into binary string
	 * 3) The bitstring remaining is the upper triangle of
	 *    the adjacency matrix.  Fill these values in to a new adjacency
	 *    matrix. Return the resulting graph.
	 */
	public static int[][] retrieveGraph(String s){
		int v = (int) (s.charAt(0)) - 63;
		int e = (v * (v-1))/2;

		int toAddSize = 6;
		
		int[][] graph = new int[v][v];
		int count = 0;
		int index = 1;
		
		int x = 1;
		int y = 0;
		
		while (count < e){
			int c = (int) (s.charAt(index)) - 63;
			int[] toAdd = new int[toAddSize];
			for(int i = toAddSize-1; i >= 0; i--){
				toAdd[i] = c & 1;
				c = c >> 1;
			}
			for (int i = 0; i < toAddSize; i++){
				if (x == y){
					graph[x][y] = 0;
					x = x+1;
					y = 0;
					if (x == v){
						return graph;
					}
				}
				graph[x][y] = toAdd[i];
				graph[y][x] = toAdd[i];
				count++;
				y++;
			}
			index++;
		}
		return graph;
	}
	
	public static void main(String[] args){
		System.out.println(Arrays.deepToString(retrieveGraph("HCfvvzz")));
	}
}
