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

int xMatrix(int** a){
	return a[0][-2];
}

int yMatrix(int** a){
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
	int n = xMatrix(a);
	int m = yMatrix(a);
	for (int i = 0; i < n; i++){
		printMatrixRow(a[i], m);
	}
	printf("]\n");
}

int compareMatrices(int** a, int** b){
	int aWidth = xMatrix(a);
	int bWidth = xMatrix(b);

	if (aWidth > bWidth){
		return 1;
	} else if (aWidth < bWidth){
		return -1;
	}

	int w = aWidth;

	int aHeight = yMatrix(a);
	int bHeight = yMatrix(b);

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

int xMatrixL(long** a){
	int result = (int) a[0][-2];
	return result;
}

int yMatrixL(long** a){
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
	int n = xMatrixL(a);
	int m = yMatrixL(a);
	for (int i = 0; i < n; i++){
		printMatrixRowL(a[i], m);
	}
	printf("]\n");
}

int compareMatricesL(long** a, long** b){

	int aWidth = xMatrixL(a);
	int bWidth = xMatrixL(b);
	int aHeight = yMatrixL(a);
	int bHeight = yMatrixL(b);

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
	int h = yMatrixL(a);
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
	int h = yMatrixL(a);
	for (int i = 0; i < h; i++){
		long temp = a[row1][i];
		a[row1][i] = a[row2][i];
		a[row2][i] = temp;	
	}
}

long** duplicateMatrixL(long** m){
	int w = xMatrixL(m);
	int h = yMatrixL(m);
	long** n = createMatrixL(w, h);
	for(int i = 0; i < w; i++){
		for (int j = 0; j < h; j++){
			n[i][j] = m[i][j];
		}
	}
	return n;
}

long** intToLongMatrix(int** m){
	int w = xMatrix(m);
	int h = yMatrix(m);
	long** n = createMatrixL(w, h);
	for(int i = 0; i < w; i++){
		for (int j = 0; j < h; j++){
			n[i][j] = (long) m[i][j];
		}
	}
	return n;
}

void destroyMatrixL(long** a){
	free(&(a[0][-3]));
	free(a);
}

/* * * * * * * * * * * * * * * * * * * * */
/*         MATRIX MULTIPLICATION         */
/* * * * * * * * * * * * * * * * * * * * */

long** multiplyLI(long** a, int** b){
	int aHeight = yMatrixL(a);
	int aWidth = xMatrixL(a);
	int bHeight = yMatrix(b);
	int bWidth = xMatrix(b);

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
	int aHeight = yMatrix(a);
	int aWidth = xMatrix(a);
	int bHeight = yMatrix(b);
	int bWidth = xMatrix(b);

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

void printArray(int* a){
	int length = lengthArray(a);
	printf("[");
	for (int i = 0; i < length-1; i++){
		printf("%d, ",a[i]);
	}
	printf("%d]\n", a[length-1]);
}

/* * * * * * * * * * * * * * * * * * * * */
/*        INTEGER LIST UTILITIES         */
/* * * * * * * * * * * * * * * * * * * * */

ListI* createListI(){
	int n = 2;
	int* values = malloc(n*sizeof(int));
	values[0] = 0;
	values[1] = 0;
	ListI* l = malloc(sizeof(ListI));
	l->values = values;
	l->size = 0;
	l->maxSize = n;
	return l;
}

void insertListI(ListI* list, int j){
	list->values[list->size] = j;
	list->size++;
	if (list->size == list->maxSize){
		int* newValues = malloc(list->size*2*sizeof(int));
		for(int i = 0; i < list->size; i++){
			newValues[i] = list->values[i];
			newValues[i + list->maxSize] = 0;
		}
		list->values = newValues;
		list->maxSize = list->size * 2;
	}
}

void printListI(ListI* li){
	printf("[");
	for (int i = 0; i < li->size; i++){
		printf("%d ", li->values[i]);
	}
	printf("]\n");
}

/* * * * * * * * * * * * * * * * * * * * */
/*          LONG LIST UTILITIES          */
/* * * * * * * * * * * * * * * * * * * * */

ListL* createListL(){
	int n = 2;
	long* values = malloc(n*sizeof(long));
	values[0] = (long) 0;
	values[1] = (long) 0;
	ListL* l = malloc(sizeof(ListL));
	l->values = values;
	l->size = 0;
	l->maxSize = n;
	return l;
}

void insertListL(ListL* list, long l){
	list->values[list->size] = l;
	list->size++;
	if (list->size == list->maxSize){
		long* newValues = malloc(list->size*2*sizeof(long));
		for(int i = 0; i < list->size; i++){
			newValues[i] = list->values[i];
			newValues[i + list->maxSize] = (long) 0;
		}
		list->values = newValues;
		list->maxSize = list->size * 2;
	}
}

int indexOfL(ListL* list, long value){
	for (int i = 0; i < list->size; i++){
		if (list->values[i] == value){
			return i;
		}
	}
	return -1;
}

void printListL(ListL* li){
	printf("[");
	for (int i = 0; i < li->size; i++){
		printf("%ld ", li->values[i]);
	}
	printf("]\n");
}

/* * * * * * * * * * * * * * * * * * * * */
/*          VOID LIST UTILITIES          */
/* * * * * * * * * * * * * * * * * * * * */

ListV* createListV(){
	int n = 2;
	void** values = malloc(n*sizeof(void*));
	values[0] = NULL;
	values[1] = NULL;
	ListV* l = malloc(sizeof(ListV));
	l->values = values;
	l->size = 0;
	l->maxSize = n;
	return l;
}

void insertListV(ListV* list, void* v){
	list->values[list->size] = v;
	list->size++;
	if (list->size == list->maxSize){
		void** newValues = malloc(list->size*2*sizeof(void*));
		for(int i = 0; i < list->size; i++){
			newValues[i] = list->values[i];
			newValues[i + list->maxSize] = NULL;
		}
		list->values = newValues;
		list->maxSize = list->size * 2;
	}
}

void printListV(ListV* li){
	printf("[");
	for (int i = 0; i < li->size; i++){
		printf("%p ", li->values[i]);
	}
	printf("]\n");
}

