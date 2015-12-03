#include <stdio.h>
#include <string.h>
#include <math.h>
#include <stdlib.h>
#include "structures.h"
#include "paths.h"

/* * * * * * * * * * * * * * * * * * * * */
/*         MATRIX MULTIPLICATION         */
/* * * * * * * * * * * * * * * * * * * * */
int** multiply(int** a, int** b){
	int aHeight = heightMatrix(a);
	int aWidth = widthMatrix(a);
	int bHeight = heightMatrix(b);
	int bWidth = widthMatrix(b);

	// Matrix multiplication requires that we have
	// a dimension match here.

	if (aWidth != bHeight){
		return NULL;
	}

	int** result = createMatrix(aHeight, bWidth);

	for (int i = 0; i < aHeight; i++){
		for (int j = 0; j < bWidth; j++){
			int total = 0;
			for (int k = 0; k < aWidth; k++){
				total += a[i][k] * b[k][j];
			}
			result[i][j] = total;
		}
	}
	return result;
}

long** multiplyL(long** a, long** b){
	int aHeight = heightMatrixL(a);
	int aWidth = widthMatrixL(a);
	int bHeight = heightMatrixL(b);
	int bWidth = widthMatrixL(b);

	// Matrix multiplication requires that we have
	// a dimension match here.

	if (aWidth != bHeight){
		return NULL;
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

long** multiplyLI(long** a, int** b){
	int aHeight = heightMatrixL(a);
	int aWidth = widthMatrixL(a);
	int bHeight = heightMatrix(b);
	int bWidth = widthMatrix(b);

	// Matrix multiplication requires that we have
	// a dimension match here.

	if (aWidth != bHeight){
		return NULL;
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

long** multiplyIL(int** a, long** b){
	int aHeight = heightMatrix(a);
	int aWidth = widthMatrix(a);
	int bHeight = heightMatrixL(b);
	int bWidth = widthMatrixL(b);

	// Matrix multiplication requires that we have
	// a dimension match here.

	if (aWidth != bHeight){
		return NULL;
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

	// Matrix multiplication requires that we have
	// a dimension match here.

	if (aWidth != bHeight){
		return NULL;
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

/* * * * * * * * * * * * * * * * * * * * */
/*              DATA ITEM                */
/* * * * * * * * * * * * * * * * * * * * */


int compareData(Data* a, Data* b){
	return(compareMatricesL(a->paths, b->paths));
}

Data* createData(int** graph){
	int v = widthMatrix(graph);
	printf("\t%d\n", v);
	Data* d = malloc(sizeof(Data));

	long** running = multiply2L(graph, graph);

	long** paths = createMatrixL(v, 1);

	for (int i = 0; i < v; i++){
		paths[i][0] = running[i][i];
	}

	sortPaths(paths);

	d->graph = graph;
	d->running = running;
	d->paths = paths;

	return d;
}

void destroyData(Data* data){
	destroyMatrix(data->graph);
	destroyMatrixL(data->running);
	destroyMatrixL(data->paths);
	free(data);
}

/* * * * * * * * * * * * * * * * * * * * */
/*           PATHS CALCULATION           */
/* * * * * * * * * * * * * * * * * * * * */

void updatePathsOneValue(Data* data){
	int** graph = data->graph;
	long** paths = data->paths;
	long** running = data->running;

	long** newRunning = multiplyLI(running, graph);

	destroyMatrixL(running);
	data->running = newRunning;

	int v = heightMatrixL(paths);
	int previousPower = widthMatrixL(paths);

	long** newPaths = createMatrixL(v, previousPower+1);
	for (int i = 0; i < v; i++){
		for (int j = 0; j < previousPower; i++){
			newPaths[i][j] = paths[i][j];
		}
		newPaths[i][previousPower] = running[i][i];
	}

	sortPaths(newPaths);
	
	destroyMatrixL(paths);
	data->paths = newPaths;
}

Data* duplicatePathsOneValue(Data* data){
	Data* d = malloc(sizeof(Data));

	int** graph = data->graph;
	long** paths = data->paths;
	long** running = data->running;

	long** newRunning = multiplyLI(running, graph);

	int v = heightMatrixL(paths);
	int previousPower = widthMatrixL(paths);

	long** newPaths = createMatrixL(v, previousPower+1);
	for (int i = 0; i < v; i++){
		for (int j = 0; j < previousPower; i++){
			newPaths[i][j] = paths[i][j];
		}
		newPaths[i][previousPower] = running[i][i];
	}

	sortPaths(newPaths);

	d->graph = graph;
	d->paths = newPaths;
	d->running = newRunning;

	return d;
}




/* * * * * * * * * * * * * * * * * * * * */
/*          SORTING CALCULATION          */
/* * * * * * * * * * * * * * * * * * * * */

void sortPaths(long** paths){
	int w = widthMatrixL(paths);
	int madeSwap = 1;
	printf("Attempting to sort at all\n");
	// SHITTY BUBBLE SORT, BUT HEY, N <= 11.
	while (madeSwap > 0){
		madeSwap = 0;
		for (int i = 0; i < w-1; i++){
			int row1 = i;
			int row2 = i+1;
			int comparison = compareMatrixRowL(paths, row1, row2);
			//printf("comparing rows %d and %d yielded %d\n",row1, row2, comparison);
			if (comparison == -1){
				swapMatrixRowL(paths, row1, row2);
				madeSwap = 1;
			}
		}
	}
}