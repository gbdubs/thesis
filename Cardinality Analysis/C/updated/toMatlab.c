#include <stdio.h>
#include <string.h>
#include <math.h>
#include <stdlib.h>
#include "graph6.h"
#include "structures.h"
#include "utilities.h"

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

void convertToMatlab(int v, int e, char* name){
	FILE *nautyFile;
	nautyFile = fopen(getFilePath(v,e), "r");
	char inputBuffer[11];
	if (nautyFile == NULL){
		printf("FILE NOT FOUND [%s]\n", getFilePath(v, e));
		return;
	}
	
	int count = 1;

	while (fscanf(nautyFile, "%s", inputBuffer) == 1){
		printf("%s(:,:,%d) = ", name, count);
		count++; 
		int** graph = retrieveGraph(inputBuffer);
		printMatrix(graph); printf(";\n");
	}
	
	fclose(nautyFile);
}

int main(int argc, char *argv[]){
	if( argc != 4 ) {
      	printf("Incorrect number of arguments supplied, only input the number of vertices, and the number of edges, and a name.\n");
    }

    int v = atoi(argv[1]);
    int e = atoi(argv[2]);

    e = min(e, (v*(v-1))/2 - e);

    convertToMatlab(v, e, argv[3]);
}