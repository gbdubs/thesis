#include <stdio.h>
#include <string.h>
#include <math.h>
#include <stdlib.h>
#include "structures.h"
#include "graph6.h"
#include "paths.h"
#include "trees.h"

const int rootLength = 44;
const char* dataRoot = "/Users/Grady/Desktop/Thesis/data/smallgraphs";

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
	if (nautyFile == NULL){
		printf("FILE NOT FOUND [%s]\n", getFilePath(v, e));
		return; 
	} else {
		printf("FILE CREATED\n");
	}
	


	int loopCount = 0;
	while (fscanf(nautyFile, "%s", inputBuffer) == 1){
		// Prints an updating statement
		if (loopCount % 1000 == 0){ printf("Processed %d graphs", loopCount); printResults(); printf("\n"); }
		
		// Retrieves the graph, calculates its paths function, sorts the vectors, and inserts it into the tree.
		insertIntoPowerTrees(createData(retrieveGraph(inputBuffer)),0);
		
		loopCount++;
	}


	printResults();
	printTrees();
	
	int maxP = maxPower();
	
	for (int i = 0; i < 10; i++){
		printf("MAX POWER!!! %d\n", maxP); 
	}
	
	fclose(nautyFile);
}

int main(){
	calculatePower(4,3);
}


void verifySortingAndSwapping(){
	long** matrixL = createMatrixL(4, 1);
	matrixL[0][0] = 0;
	matrixL[1][0] = 2;
	matrixL[2][0] = 1;
	matrixL[3][0] = 2;
	printMatrixL(matrixL);
	printf("SORTED?\n");
	sortPaths(matrixL);
	printMatrixL(matrixL);

	matrixL = createMatrixL(5, 5);
	for (int i = 0; i < 5; i++){
		for (int j = 0; j < 5; j++){
			matrixL[4-i][4-j] = (i*j)/3 -i;
		}
	}
	printMatrixL(matrixL);
	swapMatrixRowL(matrixL, 1, 4);
	printMatrixL(matrixL);
	swapMatrixRowL(matrixL, 2, 4);
	printMatrixL(matrixL);
	swapMatrixRowL(matrixL, 3, 0);
	printMatrixL(matrixL);
	swapMatrixRowL(matrixL, 1, 4);
	printMatrixL(matrixL);
	printf("SORTED?\n");
	sortPaths(matrixL);
	printMatrixL(matrixL);
}
