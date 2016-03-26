#include <stdio.h>
#include <string.h>
#include <math.h>
#include <stdlib.h>
#include "structures.h"
#include "listofStrings.h"
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
	if (dssm->nGraphs >= dssm->maxNGraphs){
		if (dssm->depth < dssm->nVertices){
			goDeeper(dssm);
			return;
		}
	} else if (dssm->nGraphs == -1){
		if (dssm->nextOnes[ds[dssm->depth]] == NULL){
			dssm->nextOnes[ds[dssm->depth]] = makeDSSM(dssm->nVertices, dssm->maxNGraphs, dssm->depth + 1);
		}
		insertDSSM(dssm->nextOnes[ds[dssm->depth]], graph6Format, ds);
		return;
	}
	if (dssm->los == NULL){
		dssm->los = newListOfGraphs(graph6Format, ds);
	} else {
		dssm->los = addToListOfGraphs(dssm->los, graph6Format, ds);
	}
	dssm->nGraphs = dssm->nGraphs + 1;
}

void goDeeper(DSSM* dssm){

	int newLevel = dssm->depth + 1;

	LOS* los = dssm->los;
	dssm->nGraphs = -1;
	dssm->los = NULL;

	while (los != NULL){

		char* encoding = los->myStr;

		int* ds = los->degreeSequence;

		DSSM* nextOne = dssm->nextOnes[ds[newLevel]];
		if (nextOne == NULL){
			nextOne = makeDSSM(dssm->nVertices, dssm->maxNGraphs, dssm->depth + 1);
			dssm->nextOnes[ds[newLevel]] = nextOne;
		} 
		insertDSSM(dssm, encoding, ds);
		los = los->next;
	}
}

void printrep(int n, char c[]){
	for(int i = 0; i < n; i++){
		printf("%s",c);
	}
}

void printDSSMStructure(DSSM* dssm, int dashes){
	printf("%d\n", dssm->id);
	for(int i = 0; i < (dssm->nVertices)-1; i++){
		if (dssm->nextOnes[i] != NULL){
			printrep(dashes, " ");
			printf("%d[%d]=", dssm->id, i);
			printDSSMStructure(dssm->nextOnes[i], dashes + 1);
		}
	}
}


int main(){
	DSSM* dssm = makeDSSM(5, 1, 1);
	int* a = createArray(5);
	int* b = createArray(5);
	int* c = createArray(5);

	for(int i = 0; i < 5; i++){
		a[i] = (i + 5) % 5;
		b[i] = (i + 5 + i) % 5;
		c[i] = (i + 5 + (i / 3)) % 5;
	}

	insertDSSM(dssm, "A", a);

	insertDSSM(dssm, "B", b);

	insertDSSM(dssm, "C", c);

	insertDSSM(dssm, "D", c);

	printDSSMStructure(dssm, 0);
}


