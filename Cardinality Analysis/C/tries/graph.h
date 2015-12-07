/* * * Include Guards * * * */
#ifndef GRAPH_H_INCLUDED
#define GRAPH_H_INCLUDED
/* * * Include Guards * * * */

/* * * * * * * * * * * * * * * * * * * * */
/*         GRAPH OBJECT UTILITIES        */
/* * * * * * * * * * * * * * * * * * * * */

typedef struct GraphGenerator {
	int** graph;
	long** running;
	int* order;
	int nextOrder;
	int id;
} Graph;

int size(Graph* g);

void advanceGraph(Graph* g);

int getOrder(int* order, int request);

Graph* createGraph(int** graph);

long getNextValue(Graph* g);

#endif