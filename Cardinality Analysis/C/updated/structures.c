#include <stdio.h>
#include <string.h>
#include <math.h>
#include <stdlib.h>

#include "structures.h"



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
	for (int i = 0; i < m-1; i++){
		printf("%d,\t",a[i]);
	}
	printf("%d],\n", a[m-1]);
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
	long* values = calloc((3+n*m),sizeof(long));
	long** rows = calloc(n , sizeof(long*));
	for (int i = 0; i < n; i++){
		rows[i] = &values[(i*m)+3];
	}
	rows[0][-2] = (long) n;
	rows[0][-1] = (long) m;
	return rows;
}

int widthMatrixL(long** a){
	int result = (int) a[0][-2];
	return result;
}

int heightMatrixL(long** a){
	int result = (int) a[0][-1];
	return result;
}

void printMatrixRowL(long* a, int m){
	printf("[");
	for (int i = 0; i < m-1; i++){
		printf("%ld,\t",a[i]);
	}
	printf("%ld],\n", a[m-1]);
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

int compareMatricesL(long** a, long** b){

	int aWidth = widthMatrixL(a);
	int bWidth = widthMatrixL(b);
	int aHeight = heightMatrixL(a);
	int bHeight = heightMatrixL(b);

	if (aWidth > bWidth || aHeight > bHeight){
		return 1;
	} else if (aWidth < bWidth || aHeight < bHeight){
		return -1;
	}

	int w = aWidth;

	for (int i = 0; i < w; i++){
		int rowComparison = compareMatrixRowL(a, i, b, i);
	}
	return 0;
}

int compareMatrixRowL(long** a, int row1, long** b, int row2){
	int h = heightMatrixL(a);
	for (int j = 0; j < h; j++){
		if (a[row1][j] > b[row2][j]){
			return 1;
		} else if (a[row1][j] < b[row2][j]){
			return -1;
		}
	}
	return 0;
}

void swapMatrixRowL(long** a, int row1, int row2){
	int h = heightMatrixL(a);
	for (int i = 0; i < h; i++){
		long temp = a[row1][i];
		a[row1][i] = a[row2][i];
		a[row2][i] = temp;	
	}
}

long** duplicateMatrixL(long** m){
	int w = widthMatrixL(m);
	int h = heightMatrixL(m);
	long** n = createMatrixL(w, h);
	for(int i = 0; i < w; i++){
		for (int j = 0; j < h; j++){
			n[i][j] = m[i][j];
		}
	}
	return n;
}