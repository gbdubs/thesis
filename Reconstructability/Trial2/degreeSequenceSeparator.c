#include <stdio.h>
#include <string.h>
#include <math.h>
#include <stdlib.h>
#include "structures.h"
#include "listofStrings.h"
#include "degreeSequence.h"
#include "graph6.h"


int DSSMID = 1;

typedef struct DegreeSequenceSeparationMechanism{
	LOS* los;
	int id;
	int nVertices;
	int nGraphs;
	int maxNGraphs;
	int depth;
	struct DegreeSequenceSeparationMechanism** nextOnes;
} DSSM;

DSSM* makeDSSM(int nVertices, int maxGraphsInTrieNode, int depth){
	DSSM* dssm = malloc(sizeof(DSSM));
	dssm->id = DSSMID;
	DSSMID = DSSMID + 1;
	dssm->los = NULL;
	dssm->nVertices = nVertices;
	dssm->nGraphs = 0;
	dssm->maxNGraphs = maxGraphsInTrieNode;
	dssm->depth = depth;
	dssm->nextOnes = malloc(sizeof(DSSM*) * (nVertices));
	for(int i = 0; i < nVertices; i++){
		dssm->nextOnes[i] = NULL;
	}
	return dssm;
}

void goDeeper(DSSM* dssm);

void insertDSSM(DSSM* dssm, char graph6Format[], int* ds){
	//printf("INSERTING INTO %d at depth %d ", dssm->id, dssm->depth);
	//printArray(ds);
	//printf("\n");

	if (dssm->nGraphs >= dssm->maxNGraphs){
		//printf("case A\n");
		if (dssm->depth < dssm->nVertices){
			goDeeper(dssm);
			insertDSSM(dssm, graph6Format, ds);
			return;
		}
	} else if (dssm->nGraphs == -1){
		//printf("case B\n");
		if (dssm->nextOnes[ds[dssm->depth]] == NULL){
			dssm->nextOnes[ds[dssm->depth]] = makeDSSM(dssm->nVertices, dssm->maxNGraphs, dssm->depth + 1);
		}
		insertDSSM(dssm->nextOnes[ds[dssm->depth]], graph6Format, ds);
		return;
	}
	if (dssm->los == NULL){
		//printf("case C\n");
		dssm->los = newListOfGraphs(graph6Format, ds);
	} else {
		//printf("case D\n");
		dssm->los = addToListOfGraphs(dssm->los, graph6Format, ds);
	}
	dssm->nGraphs = dssm->nGraphs + 1;
}

void goDeeper(DSSM* dssm){
	//printf("Going Deeper!\n");

	int oldLevel = dssm->depth;
	int newLevel = dssm->depth + 1;

	LOS* los = dssm->los;
	dssm->nGraphs = -1;
	dssm->los = NULL;

	while (los != NULL){

		char* encoding = los->myStr;
		int* ds = los->degreeSequence;

		DSSM* nextOne = dssm->nextOnes[ds[oldLevel]];

		if (nextOne == NULL){
			nextOne = makeDSSM(dssm->nVertices, dssm->maxNGraphs, newLevel);
			dssm->nextOnes[ds[oldLevel]] = nextOne;
		} 

		insertDSSM(nextOne, encoding, ds);
		los = los->next;
	}
}

void printrep(int n, char c[]){
	for(int i = 0; i < n; i++){
		printf("%s",c);
	}
}

void printDSSMStructure(DSSM* dssm, int dashes){
	printf("%d #=%d\n", dssm->id, dssm->nGraphs);
	for(int i = 0; i < dssm->nVertices; i++){
		if (dssm->nextOnes[i] != NULL){
			printrep(dashes, " ");
			printf("%d[%d]=", dssm->id, i);
			printDSSMStructure(dssm->nextOnes[i], dashes + 1);
		}
	}
}

/*
const char* BASEPATH = "/Users/Grady/Desktop/Thesis/Reconstructability/data/2separated";

void saveDSSMStructureToFiles(DSSM* dssm, char* toPrint){
	if (dssm->nGraphs > 0){

		char temp[1000];
		sprintf(temp, "%s/%s.txt", BASEPATH, toPrint);

		FILE* recorder = fopen(temp, "w");

		if (recorder == NULL){
			{
			    printf("Error Opening File [%s]\n", temp);
			    exit(1);
			}
		}

		LOS* los = dssm->los;
		while (los != NULL){
			fprintf(recorder, "%s\n", los->myStr);
			los = los->next;
		}

		fclose(recorder);

	} else {
		for (int i = 0; i < dssm->nVertices; i++){
			if (dssm->nextOnes[i] != NULL){
				char temp[1000];
				sprintf(temp,"%s-%d",toPrint,i);
				saveDSSMStructureToFiles(dssm->nextOnes[i], temp);
			}
		}
	}

}






const int rootLength = 69;
const char* dataRoot = "/Users/Grady/Desktop/Thesis/Reconstructability/Trial2/data/1graphdata";

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

FILE *nautyFile;

int separateOutDSSMStructure(int v, int e){

	DSSM* dssm = makeDSSM(v, 2000, 0);

	nautyFile = fopen(getFilePath(v,e), "r");
	
	if (nautyFile == NULL){
		printf("FILE NOT FOUND [%s]\n", getFilePath(v, e));
		return -1;
	}
	
	int loopCount = 0;
	char inputBuffer[11];
	while (fscanf(nautyFile, "%s", inputBuffer) == 1){
		
		char* newBuffer = malloc(11 * sizeof(char));
		sprintf(newBuffer, "%s", inputBuffer);

		if (loopCount % 1000 == 0){ 
			printf("Processed %d graphs\n", loopCount); 
		}

		int* ds = getDegreeSequence(newBuffer);
		insertDSSM(dssm, newBuffer, ds);

		loopCount++;
	}

	// printDSSMStructure(dssm, 0);

	char temp[1000];
	sprintf(temp, "V%d-E%d", v, e);

	saveDSSMStructureToFiles(dssm, temp);
	
	fclose(nautyFile);

	return 1;
}

int main(int argc, char *argv[]){
	int vmax = atoi(argv[1]);

	printf("s = %s, vmax = %d\n", argv[1], vmax);

	for(int v = 1; v <= vmax; v++){
		for(int e = 0; e <= (v * v - v) / 2; e++){
			separateOutDSSMStructure(v, e);
		}
	}
}