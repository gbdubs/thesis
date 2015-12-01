#include <stdio.h>
#include <string.h>
#include <math.h>
#include <stdlib.h>

#include "structures.h"

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

/* * * * * * * * * * * * * * * * * * * * */
/*          MATRIX UTILITIES             */
/* * * * * * * * * * * * * * * * * * * * */

int** createMatrix(int n, int m){
	int* values = malloc((2+n*m)*sizeof(int));
	values[0] = n;
	values[1] = m;
	int** rows = malloc(n * sizeof(int*));
	for (int i = 0; i < n; i++){
		rows[i] = &values[(i*m)+2];
	}
	return rows;
}

int widthMatrix(int** a){
	return a[0][-2];
}

int heightMatrix(int** a){
	return a[0][-1];
}

void printMatrixRow(int* a, int m){
	printf("[");
	for (int i = 0; i < m; i++){
		printf("%d,\t",a[i]);
	}
	printf("%d]\n", a[m-1]);
}

void printMatrix(int** a){
	printf("[\n");
	int n = widthMatrix(a);
	int m = heightMatrix(a);
	for (int i = 0; i < n; i++){
		printMatrixRow(a[i], m);
	}
	printf("]\n");
}

void destroyMatrix(int** a){
	free(a);
	free(&a[0][-2]);
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

int compareMatrices(int** a, int** b){
	int aWidth = widthMatrix(a);
	int bWidth = widthMatrix(b);

	if (aWidth > bWidth){
		return 1;
	} else if (aWidth < bWidth){
		return -1;
	}

	int w = aWidth;

	int aHeight = heightMatrix(a);
	int bHeight = heightMatrix(b);

	if (aHeight > bHeight){
		return 1;
	} else if (aHeight < bHeight){
		return -1;
	}

	int l = aWidth;

	for (int i = 0; i < w; i++){
		for (int j = 0; j < l; j++){
			if (a[i][j] > b[i][j]){
				return 1;
			} else if (a[i][j] < b[i][j]){
				return -1;
			}
		}
	}
	return 0;
}

/* * * * * * * * * * * * * * * * * * * * */
/*         LONG MATRIX UTILITIES         */
/* * * * * * * * * * * * * * * * * * * * */

long** createMatrixL(int n, int m){
	long* values = malloc((2+n*m)*sizeof(long));
	values[0] = n;
	values[1] = m;
	long** rows = malloc(n * sizeof(long*));
	for (int i = 0; i < n; i++){
		rows[i] = &values[(i*m)+2];
	}
	return rows;
}

int widthMatrixL(long** a){
	return a[0][-2];
}

int heightMatrixL(long** a){
	return a[0][-1];
}

void printMatrixRowL(long* a, int m){
	printf("[");
	for (int i = 0; i < m; i++){
		printf("%ld,\t",a[i]);
	}
	printf("%ld]\n", a[m-1]);
}

void printMatrixL(long** a){
	printf("[\n");
	int n = widthMatrixL(a);
	int m = heightMatrixL(a);
	for (int i = 0; i < n; i++){
		printMatrixRowL(a[i], m);
	}
	printf("]\n");
}

void destroyMatrixL(long** a){
	free(a);
	free(&a[0][-2]);
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

int compareMatricesL(long** a, long** b){
	int aWidth = widthMatrixL(a);
	int bWidth = widthMatrixL(b);

	if (aWidth > bWidth){
		return 1;
	} else if (aWidth < bWidth){
		return -1;
	}

	int w = aWidth;

	int aHeight = heightMatrixL(a);
	int bHeight = heightMatrixL(b);

	if (aHeight > bHeight){
		return 1;
	} else if (aHeight < bHeight){
		return -1;
	}

	int l = aWidth;

	for (int i = 0; i < w; i++){
		for (int j = 0; j < l; j++){
			if (a[i][j] > b[i][j]){
				return 1;
			} else if (a[i][j] < b[i][j]){
				return -1;
			}
		}
	}
	return 0;
}

int compareMatrixRowL(long** a, int row1, int row2){
	int w = widthMatrixL(a);
	for (int j = 0; j < w; j++){
		if (a[row1][j] > a[row2][j]){
			return 1;
		} else if (a[row1][j] < a[row2][j]){
			return -1;
		}
	}
	return 0;
}

void swapMatrixRowL(long** a, int row1, int row2){
	int w = widthMatrixL(a);
	for (int i = 0; i < w; i++){
		long temp = a[row1][i];
		a[row1][i] = a[row2][i];
		a[row2][i] = temp;	
	}
}