#include <stdio.h>
#include <string.h>
#include <math.h>
#include <stdlib.h>
#include "structures.h"
#include "listOfStrings.h"

LOS* newListOfGraphs(char* s, int* ds){
	LOS* newLos = malloc(sizeof(LOS));
	newLos->next = NULL;
	newLos->size = 1;
	newLos->myStr = s;
	newLos->degreeSequence = ds;
	return newLos;
}

LOS* addToListOfGraphs(LOS* los, char* s, int* ds){
	LOS* newLos = malloc(sizeof(LOS));
	newLos->next = los;
	newLos->size = los->size + 1;
	newLos->myStr = s;
	newLos->degreeSequence = ds;
	return newLos;
}

void printListOfGraphs(LOS* los){
	if (los != NULL){
		printf("%s\n", los->myStr);
		printArray(los->degreeSequence);
		printListOfGraphs(los->next);
	}
}
/*
int main(){
	char a[] = "hello";
	int* aa = createArray(10);
	aa[0] = 10;
	char b[] = "world";
	int* bb = createArray(1);
	bb[0] = 1;
	char c[] = "ellie";
	int* cc = createArray(5);
	cc[0] = 5;
	LOS* los = newListOfGraphs(a, aa);
	los = addToListOfGraphs(los, b, bb);
	los = addToListOfGraphs(los, c, cc);
	printListOfGraphs(los);
}
*/