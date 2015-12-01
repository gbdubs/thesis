#include "structures.h"
#include "paths.h"

/* * * * * * * * * * * * * * * * * * * * */
/*         MATRIX MULTIPLICATION         */
/* * * * * * * * * * * * * * * * * * * * */
int** multiply(int** a, int** b){
	int aHeight = matrixHeight(a);
	int aWidth = matrixWidth(a);
	int bHeight = matrixHeight(b);
	int bWidth = matrixWidth(b);

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
	int aHeight = matrixHeightL(a);
	int aWidth = matrixWidthL(a);
	int bHeight = matrixHeightL(b);
	int bWidth = matrixWidthL(b);

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
	int aHeight = matrixHeightL(a);
	int aWidth = matrixWidthL(a);
	int bHeight = matrixHeight(b);
	int bWidth = matrixWidth(b);

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
	int aHeight = matrixHeight(a);
	int aWidth = matrixWidth(a);
	int bHeight = matrixHeightL(b);
	int bWidth = matrixWidthL(b);

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
	int aHeight = matrixHeight(a);
	int aWidth = matrixWidth(a);
	int bHeight = matrixHeight(b);
	int bWidth = matrixWidth(b);

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


int compare(Data* a, data* b){
	return(createMatrixL(a->paths, b->paths));
}

Data* createData(int** graph){
	int v = matrixWidth(graph);

	Data* d = malloc(sizeof(Data));

	long** running = multiply2L(graph, graph);

	long** paths = createMatrixL(v, 1);

	for (int i = 0; i < v; i++){
		paths[i][1] = running[i][i];
	}

	sortPaths(running);

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

	destroyMatrix(running);
	data->running = newRunning;

	int v = matrixHeightL(paths);
	int previousPower = matrixWidthL(paths);

	long** newPaths = createMatrix(v, previousPower+1);
	for (int i = 0; i < v; i++){
		for (int j = 0; j < previousPower; i++){
			newPaths[i][j] = paths[i][j];
		}
		newPaths[i][previousPower] = running[i][i];
	}

	sortPaths(newRunning);
	
	destroyMatrix(paths);
	data->paths = newPaths;
}

Data* duplicatePathsOneValue(Data* data){
	Data d = {NULL, NULL, NULL};

	int** graph = data->graph;
	long** paths = data->paths;
	long** running = data->running;

	long** newRunning = multiplyLI(running, graph);

	int v = matrixHeightL(paths);
	int previousPower = matrixWidthL(paths);

	long** newPaths = createMatrix(v, previousPower+1);
	for (int i = 0; i < v; i++){
		for (int j = 0; j < previousPower; i++){
			newPaths[i][j] = paths[i][j];
		}
		newPaths[i][previousPower] = running[i][i];
	}
	
	sortPaths(newRunning);

	d->graph = graph;
	d->paths = newPaths;
	d->running = newRunning;

	return d;
}




/* * * * * * * * * * * * * * * * * * * * */
/*          SORTING CALCULATION          */
/* * * * * * * * * * * * * * * * * * * * */

void sortPaths(long** paths){
	int h = matrixHeightL(paths);
	int madeSwap = 0;
	// SHITTY BUBBLE SORT, BUT HEY, N <= 11.
	while (madeSwap){
		madeSwap = 0;
		for (int i = 0; i < h-1; i++){
		int row1 = i;
		int row2 = i+1;
		if (compareMatrixRowsL(paths, row1, row2) == -1){
			swapMatrixRowsL(paths, row1, row2);
			madeSwap = 1;
		}
	}
}

