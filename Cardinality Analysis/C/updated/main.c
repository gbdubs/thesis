#include <stdio.h>
#include <string.h>
#include <math.h>
#include <stdlib.h>
#include "structures.h"
#include "graph6.h"
#include "paths.h"
#include "trees.h"

const int rootLength = 35;
const char* dataRoot = "/home/u/fall12/gward/Desktop/graphs";

char* getFilePath(int v, int e){
	int formatLength = 6;
	int vLength = (v > 10) + 1;
	int eLength = (e > 10) + 1;
	int totalLength = rootLength + formatLength + vLength + eLength;
	
	char* result = malloc(totalLength*sizeof(char));
	const char* format = "%s/%d-%d.txt";
	sprintf(result, format, dataRoot, v, e);
	
	return result;
}

void calculatePower(int v, int e){
	
	FILE *nautyFile;
	nautyFile = fopen(getFilePath(v,e), "r");
	char inputBuffer[11];
	
	int loopCount = 0;
	while (fscanf(nautyFile, "%s", inputBuffer) == 1){
		// Prints an updating statement
		if (loopCount % 1000 == 0){ printf("Processed %d graphs", loopCount); printResults(); printf("\n"); }

		// Retrieves the graph, calculates its paths function, sorts the vectors, and inserts it into the tree.
		insertIntoPowerTrees(createData(retrieveGraph(inputBuffer)),0);
		
		loopCount++;
	}

	printResults();
	
	int maxP = maxPower();
	
	for (int i = 0; i < 10; i++){
		printf("MAX POWER!!! %d", maxP); 
	}
	
	fclose(nautyFile);
}


int main(){
	calculatePower(6, 9);
}
