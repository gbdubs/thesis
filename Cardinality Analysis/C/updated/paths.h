/* * Include Guards * * */
#ifndef PATHS_H_INCLUDED
#define PATHS_H_INCLUDED
/* * Include Guards * * */

/* * * * * * * * * * * * * * * * * * * * */
/*              DATA ITEM                */
/* * * * * * * * * * * * * * * * * * * * */

typedef struct DataItem {
	int** graph;
	long** running;
	long** paths;
} Data;

int compareData(Data* a, Data* b);
Data* createData(int** graph);
void destroyData(Data* data);

/* * * * * * * * * * * * * * * * * * * * */
/*         MATRIX MULTIPLICATION         */
/* * * * * * * * * * * * * * * * * * * * */
int** multiply(int** a, int** b);
long** multiplyL(long** a, long** b);
long** multiplyLI(long** a, int** b);
long** multiplyIL(int** a, long** b);
long** multiply2L(int** a, int** b);


/* * * * * * * * * * * * * * * * * * * * */
/*           PATHS CALCULATION           */
/* * * * * * * * * * * * * * * * * * * * */

void updatePathsOneValue(Data* data);
Data* duplicatePathsOneValue(Data* data);
void sortPaths(long** paths);

#endif