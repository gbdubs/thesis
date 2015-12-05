/* * * Include Guards * * * */
#ifndef STRUCTURES_H_INCLUDED
#define STRUCTURES_H_INCLUDED
/* * * Include Guards * * * */

/* * * * * * * * * * * * * * * * * * * * */
/*          MATRIX UTILITIES             */
/* * * * * * * * * * * * * * * * * * * * */

int** createMatrix(int n, int m);

int xMatrix(int** a);

int yMatrix(int** a);

void printMatrix(int** a);

int compareMatrices(int** a, int** b);


/* * * * * * * * * * * * * * * * * * * * */
/*        LONG MATRIX UTILITIES          */
/* * * * * * * * * * * * * * * * * * * * */

long** createMatrixL(int n, int m);

int xMatrixL(long** a);

int yMatrixL(long** a);

void printMatrixL(long** a);

int compareMatricesL(long** a, long** b);

int compareMatrixRowL(long** a, int row1, long** b, int row2);

void swapMatrixRowL(long** a, int row1, int row2);

long** duplicateMatrixL(long** m);

long** intToLongMatrix(int** m);

void destroyMatrixL(long** a);

/* * * * * * * * * * * * * * * * * * * * */
/*         MATRIX MULTIPLICATION         */
/* * * * * * * * * * * * * * * * * * * * */

long** multiply2L(int** a, int** b);

long** multiplyLI(long** a, int** b);

/* * * * * * * * * * * * * * * * * * * * */
/*           ARRAY UTILITIES             */
/* * * * * * * * * * * * * * * * * * * * */

int* createArray(int n);

int lengthArray(int* a);

void destroyArray(int* a);

void printArray(int* a);

#endif