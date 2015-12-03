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
	long** sortedPaths;
} Data;

int compareData(Data* a, Data* b);
Data* createData(int** graph);
void destroyData(Data* data);

/* * * * * * * * * * * * * * * * * * * * */
/*           PATHS CALCULATION           */
/* * * * * * * * * * * * * * * * * * * * */

void updatePathsOneValue(Data* data);
Data* duplicatePathsOneValue(Data* data);
void sortPaths(long** paths);

#endif