#include <stdio.h>
#include <string.h>
#include <math.h>
#include <stdlib.h>
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
int** decodeGraph(char s[]){
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

/*
 * The Inverse function for decode graph, this is to allow us to only store
 * one of our critical values (the Graph) inside the trie node, but still have
 * quick access to its encoded Graph6 form. The code is self explanatory, given
 * the above code.
 */
char* encodeGraph(int** graph){
	int v = xMatrix(graph);
	int e = (v * (v-1))/2;
	int nChars = (e - 1) / 6 + 2;
	char* chars = malloc(nChars*sizeof(char)+1);
	chars[nChars] = 0;

	int i = 0;
	int j = 0;

	chars[0] = (char) (63 + v);

	int charNum = 1;
	while (i < v && j < v && charNum < nChars){
		int running = 0;
		for (int bitCount = 0; bitCount < 6; bitCount++){
			if (i == j){
				j = 0;
				i = i+1;
			}
			running = running << 1;
			if (i < v && j < v){
				running = running | (graph[i][j]);
			}
			j++;
		}
		char c = (char) (running + 63);
		chars[charNum] = c;
		charNum++;
	}
	return chars;
}

/*
 * A helper function to guarentee that the graphs that we produce from our
 * encoding and decoding are internally consistent.  Since we verified the
 * graph6 decoding using matlab, the encoding for the graph6 format must be
 * correct, as it is an inverse function for every input that I have tried.
 */
int verifyEncodingAndDecoding(char s[]){
	int** graph = decodeGraph(s);
	char* r = encodeGraph(graph);
	int comparison = strcmp(r, s);
	if (comparison != 0){
		printf("ERROR!!! Expected [%s] but got [%s]!!!\n", s, r);
	} else {
		printf("Ecoding correct for [%s].\n", s);
	}
	return comparison;
}

/* 
 * A main method, for those who would like to verify the encodings/decodings 
 */
/*
int main(){
	verifyEncodingAndDecoding("ICQQShIlO");
	verifyEncodingAndDecoding("G?AFnw");
	verifyEncodingAndDecoding("FCXkw");
	verifyEncodingAndDecoding("F?bmw");
	verifyEncodingAndDecoding("HCOcbQd");
	verifyEncodingAndDecoding("J??CB@|vv}?");
}
 */