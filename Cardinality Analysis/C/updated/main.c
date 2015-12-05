#include <stdio.h>
#include <string.h>
#include <math.h>
#include <stdlib.h>
#include "utilities.h"
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

int calculatePower(int v, int e){
	
	FILE *nautyFile;
	nautyFile = fopen(getFilePath(v,e), "r");
	char inputBuffer[11];
	if (nautyFile == NULL){
		printf("FILE NOT FOUND [%s]\n", getFilePath(v, e));
		return -1; 
	}
	
	int loopCount = 0;
	while (fscanf(nautyFile, "%s", inputBuffer) == 1){
		
		if (loopCount % 1000 == 0){ 
			printf("Processed %d graphs\n", loopCount); 
		}

		// Retrieves the graph, calculates its paths function, sorts the vectors, and inserts it into the tree.
		int** graph = retrieveGraph(inputBuffer);
		Data* data = createData(graph);
		insertIntoPowerTrees(data,0);

		loopCount++;
	}

	printResults();
	printTrees();

	int maxP = maxPower();
	
	fclose(nautyFile);
	
	return maxP;
}


int main(int argc, char *argv[]){
	if( argc != 3 ) {
      	printf("Incorrect number of arguments supplied: [NVERTICES] [NEDGES]\n");
    	exit(1);
    }

    int v = atoi(argv[1]);
    int e = atoi(argv[2]);

    int eOrig = e;
    e = min(e, (v*(v-1))/2 - e);

    printf("(%d,%d) -> %d\n", v , eOrig, calculatePower(v, e));
}