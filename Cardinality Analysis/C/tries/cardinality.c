#include <stdio.h>
#include <string.h>
#include <math.h>
#include <stdlib.h>
#include "structures.h"
#include "graph6.h"
#include "graph.h"
#include "trie.h"

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
	
	Node* root = createRoot();

	FILE *nautyFile;
	nautyFile = fopen(getFilePath(v,e), "r");
	char inputBuffer[11];
	if (nautyFile == NULL){
		printf("FILE NOT FOUND [%s]\n", getFilePath(v, e));
		return -1; 
	}
	
	int loopCount = 0;
	while (fscanf(nautyFile, "%s", inputBuffer) == 1){

		// Retrieves the graph, calculates its paths function, sorts the vectors, and inserts it into the tree.
		int** graph = retrieveGraph(inputBuffer);
		
		Graph* g = createGraph(graph);

		insert(root, g);

		loopCount++;
	}

	int maxP = height(root);
	
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

    // Replaces e with maxE - V if it can save us computational power
    int maxE = (v*(v-1))/2;
    int eOrig = e;
    if (maxE - e < e){
    	e = maxE - e;
    }

    printf("(%d,%d) -> %d\n", v , eOrig, calculatePower(v, e));
}