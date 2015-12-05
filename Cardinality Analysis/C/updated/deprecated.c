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

/* * * * * * * * * * * * * * * * * * * * */
/*           ARRAY UTILITIES             */
/* * * * * * * * * * * * * * * * * * * * */

int* createArray(int n){
	int* values = malloc((1+n)*sizeof(int));
	values[0] = n;
	return &values[1];
}

int lengthArray(int* a){
	return a[-1];
}

void destroyArray(int* a){
	free(&a[-1]);
}

int compareArrays(int* a, int* b){
	int aLength = lengthArray(a);
	int bLength = lengthArray(b);

	if (aLength > bLength){
		return 1;
	} else if (aLength < bLength){
		return -1;
	}

	for (int i = 0; i < aLength; i++){
		if (a[i] > b[i]){
			return 1;
		} else if (a[i] < b[i]){
			return -1;
		}
	}

	return 0;
}


void printArray(int* a){
	int length = lengthArray(a);
	printf("[");
	for (int i = 0; i < length-1; i++){
		printf("%d, ",a[i]);
	}
	printf("%d]\n", a[length-1]);
}


void veryifyArrayMemorySafe(){
	int size = 1500;
	while(1){
		int* a = createArray(size);
		for(int i = 0; i < size; i++){
			a[i] = i;
		}
		destroyArray(a);
	}
}


void verifyMatrixMemorySafe(){
	int n = 15;
	int m = 20;
	int k = 1;
	while(k){
		int** a = createMatrix(n, m);
		for(int i = 0; i < n; i++){
			for(int j = 0; j < m; j++){
				a[i][j] = i+j;
			}
		}
		destroyMatrix(a);
	}
}

void verifyMatrixMemorySafeL(){
	int n = 15;
	int m = 20;
	int k = 1;
	while(k){
		long** a = createMatrixL(n, m);
		for(int i = 0; i < n; i++){
			for(int j = 0; j < m; j++){
				a[i][j] = i+j;
			}
		}
		destroyMatrixL(a);
	}
}