#include <stdio.h>
#include <string.h>
#include <math.h>
#include <stdlib.h>
#include "structures.h"
#include "paths.h"

/* * * * * * * * * * * * * * * * * * * * */
/*              Prototypes               */
/* * * * * * * * * * * * * * * * * * * * */
long** multiply2L(int** a, int** b);
long** multiplyLI(long** a, int** b);


/* * * * * * * * * * * * * * * * * * * * */
/*              DATA ITEM                */
/* * * * * * * * * * * * * * * * * * * * */

Data* createData(int** graph){
	int v = widthMatrix(graph);

	Data* d = malloc(sizeof(Data));

	long** running = multiply2L(graph, graph);

	long** paths = createMatrixL(v, 1);

	for (int i = 0; i < v; i++){
		paths[i][0] = running[i][i];
	}

	long** sortedPaths = duplicateMatrixL(paths);

	sortPaths(sortedPaths);

	d->graph = graph;
	d->running = running;
	d->paths = paths;
	d->sortedPaths = sortedPaths;

	return d;
}

int compareData(Data* a, Data* b){
	return compareMatricesL(a->sortedPaths, b->sortedPaths);
}

/* * * * * * * * * * * * * * * * * * * * */
/*           PATHS CALCULATION           */
/* * * * * * * * * * * * * * * * * * * * */

Data* duplicatePathsOneValue(Data* data){
	Data* d = malloc(sizeof(Data));

	int** graph = data->graph;
	long** paths = data->paths;
	long** running = data->running;

	long** newRunning = multiplyLI(running, graph);

	int v = widthMatrixL(paths);
	int previousPower = heightMatrixL(paths);

	long** newPaths = createMatrixL(v, previousPower+1);

	for (int i = 0; i < v; i++){
		for (int j = 0; j < previousPower; j++){
			newPaths[i][j] = paths[i][j];
		}
		newPaths[i][previousPower] = newRunning[i][i];
	}

	long** sortedPaths = duplicateMatrixL(newPaths);

	sortPaths(sortedPaths);

	d->graph = graph;
	d->paths = newPaths;
	d->sortedPaths = sortedPaths;
	d->running = newRunning;

	return d;
}

/* * * * * * * * * * * * * * * * * * * * */
/*          SORTING CALCULATION          */
/* * * * * * * * * * * * * * * * * * * * */

// Bubble Sort on Row Vectors. Shitty, but since N <= 11, I wouldn't 
// worry about it too much at least you know it is right, right?
void sortPaths(long** paths){
	int w = widthMatrixL(paths);
	int madeSwap = 1;
	while (madeSwap > 0){
		madeSwap = 0;
		for (int i = 0; i < w-1; i++){
			int row1 = i;
			int row2 = i+1;
			int comparison = compareMatrixRowL(paths, row1, paths, row2);
			if (comparison == -1){
				swapMatrixRowL(paths, row1, row2);
				madeSwap = 1;
			}
		}
	}
}

/* * * * * * * * * * * * * * * * * * * * */
/*         MATRIX MULTIPLICATION         */
/* * * * * * * * * * * * * * * * * * * * */

long** multiplyLI(long** a, int** b){
	int aHeight = heightMatrixL(a);
	int aWidth = widthMatrixL(a);
	int bHeight = heightMatrix(b);
	int bWidth = widthMatrix(b);

	if (aWidth != bHeight){
		return NULL; // Verifies Dimension Match
	}

	long** result = createMatrixL(aHeight, bWidth);

	for (int i = 0; i < aHeight; i++){
		for (int j = 0; j < bWidth; j++){
			long total = 0;
			for (int k = 0; k < aWidth; k++){
				total += a[i][k] * b[k][j];
			}
			result[i][j] = total;
		}
	}
	return result;
}

long** multiply2L(int** a, int** b){
	int aHeight = heightMatrix(a);
	int aWidth = widthMatrix(a);
	int bHeight = heightMatrix(b);
	int bWidth = widthMatrix(b);

	if (aWidth != bHeight){
		return NULL; // Verifies Dimension Match
	}
	
	long** result = createMatrixL(aHeight, bWidth);

	for (int i = 0; i < aHeight; i++){
		for (int j = 0; j < bWidth; j++){
			long total = 0;
			for (int k = 0; k < aWidth; k++){
				total += a[i][k] * b[k][j];
			}
			result[i][j] = total;
		}
	}
	return result;
}