#include "structures.h"
#include "graph6.h"

/* * * * * * * * * * * * * * * * * * * * */
/*        GRAPH6 GRAPH CONVERTER         */
/* * * * * * * * * * * * * * * * * * * * */

/*
 * Converts a string in Graph6 format to an adjacency
 * matrix for manipulation.
 * 1) Remove the first character from s (it tells you v), calculate e.
 * 2) For each character, subtract 63, convert into binary string
 * 3) The bitstring remaining is the upper triangle of
 *    the adjacency matrix.  Fill these values in to a new adjacency
 *    matrix. Return the resulting graph.
 */
int** retrieveGraph(char s[]){
	int v = (int) (s[0]) - 63;
	int e = (v * (v-1))/2;

	// TODO: Figure out a way to not hard code this.
	int toAddSize = 6;

	int** graph = createMatrix(v, v);
	int count = 0;
	int index = 1;
	int x = 1;
	int y = 0;
	while (count < e){
		int c = (int) (s[index]) - 63;
		int toAdd[toAddSize];
		for(int i = toAddSize-1; i >= 0; i--){
			toAdd[i] = c % 2;
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
