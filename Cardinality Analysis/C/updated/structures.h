/* * * Include Guards * * * */
#ifndef STRUCTURES_H_INCLUDED
#define STRUCTURES_H_INCLUDED
/* * * Include Guards * * * */

/* * * * * * * * * * * * * * * * * * * * */
/*          MATRIX UTILITIES             */
/* * * * * * * * * * * * * * * * * * * * */

int** createMatrix(int n, int m);

int widthMatrix(int** a);

int heightMatrix(int** a);

void printMatrix(int** a);

int compareMatrices(int** a, int** b);


/* * * * * * * * * * * * * * * * * * * * */
/*        LONG MATRIX UTILITIES          */
/* * * * * * * * * * * * * * * * * * * * */

long** createMatrixL(int n, int m);

int widthMatrixL(long** a);

int heightMatrixL(long** a);

void printMatrixL(long** a);

int compareMatricesL(long** a, long** b);

int compareMatrixRowL(long** a, int row1, long** b, int row2);

void swapMatrixRowL(long** a, int row1, int row2);

long** duplicateMatrixL(long** m);

#endif