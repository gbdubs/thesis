#include "utilities.h"

/* * * * * * * * * * * * * * * * * * * * */
/*            MATH UTILITIES             */
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