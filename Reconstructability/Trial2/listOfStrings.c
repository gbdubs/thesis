#include <stdio.h>
#include <string.h>
#include <math.h>
#include <stdlib.h>
#include "structures.h"
#include "listOfStrings.h"

LOS* newListOfGraphs(char* s, int** dsm){
	LOS* newLos = malloc(sizeof(LOS));
	newLos->next = NULL;
	newLos->size = 1;
	newLos->myStr = s;
	newLos->degreeSequenceMatrix = dsm;
	return newLos;
}

LOS* addToListOfGraphs(LOS* los, char* s, int* dsm){
	LOS* newLos = malloc(sizeof(LOS));
	newLos->next = los;
	newLos->size = los->size + 1;
	newLos->myStr = s;
	newLos->degreeSequenceMatrix = dsm;
	return newLos;
}

void printListOfGraphs(LOS* los){
	if (los != NULL){
		printf("%s\n", los->myStr);
		printMatrix(los->degreeSequenceMatrix);
		printListOfGraphs(los->next);
	}
}