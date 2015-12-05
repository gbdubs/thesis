#include <stdio.h>
#include <string.h>
#include <math.h>
#include <stdlib.h>
#include "structures.h"

typedef struct OrderMap {
	int oldOrder;
	int newValue;
	int graphIndex;
	int newOrder;
} OM;

OM* createOM(int oo, int nv, int gi, int no){
	OM* om = malloc(sizeof(OM));
	om->oldOrder = oo;
	om-> newValue = nv;
	om->graphIndex = gi;
	om->newOrder = no;
	return om;
}

int compareOrderMapElements(OM* o, OM* m){
	if (o->oldOrder < m->oldOrder){
		return 1;
	}
	if (o->oldOrder > m->oldOrder){
		return -1;
	}

	if (o->newValue < m->newValue){
		return 1;
	}
	if (o->newValue > m->newValue){
		return -1;
	}
	return 0;
}

void printOMs(OM* oms[], int n){
	printf("OO [");
	for (int i = 0; i < n; i++){
		printf("%d ", oms[i]->oldOrder);
	}
	printf("]\n");
	printf("NV [");
	for (int i = 0; i < n; i++){
		printf("%d ", oms[i]->newValue);
	}
	printf("]\n");
	printf("GI [");
	for (int i = 0; i < n; i++){
		printf("%d ", oms[i]->graphIndex);
	}
	printf("]\n");
	printf("NO [");
	for (int i = 0; i < n; i++){
		printf("%d ", oms[i]->newOrder);
	}
	printf("]\n\n");
}

void sortOrderMap(OM* oms[], int n){
	int madeSwap = 1;
	while (madeSwap == 1){
		madeSwap = 0;
		for (int i = 0; i < n-1; i++){
			int comparison = compareOrderMapElements(oms[i], oms[i+1]);
			if (comparison == -1){
				OM* temp = oms[i];
				oms[i] = oms[i+1];
				oms[i+1] = temp;
				madeSwap = 1;
			}
		}
	}
	oms[0]->newOrder = 0;
	for (int i = 1; i < n; i++){
		int comparison = compareOrderMapElements(oms[i], oms[i-1]);
		if (comparison == 0){
			oms[i]->newOrder = oms[i-1]->newOrder;
		} else {
			oms[i]->newOrder = i;
		}
	}
}

typedef struct GraphGenerator {
	int** graph;
	long** running;
	int* order;
	int nextOrder;
} Graph;

int size(Graph* g){
	return xMatrix(g->graph);
}

void advanceGraph(Graph* g){
	int v = size(g);

	long** old = g->running;
	g->running = multiplyLI(g->running, g->graph);
	destroyMatrixL(old);
	g->nextOrder = 0;

	OM** oms = malloc(v * sizeof(OM*));
	for (int i = 0; i < v; i++){
		OM* om = createOM(g->order[i], g->running[i][i], i, 0);
		oms[i] = om;
	}
	sortOrderMap(oms, v);
	for (int i = 0; i < v; i++){
		g->order[oms[i]->graphIndex] = oms[i]->newOrder;
	}
}

int getOrder(int* order, int request){
	int length = lengthArray(order);

	int lessThan = 0;
	for(int offset = 0; offset < 0100; offset++){
		int lookingFor = request - offset;
		int numToGet = offset + 1;
		for (int i = 0; i < length; i++){
			if (order[i] == lookingFor){
				numToGet--;
				if (numToGet == 0){
					return i;
				}
			}
		}
	}
	
	return -1;
}

Graph* createGraph(int** graph){
	Graph* g = malloc(sizeof(Graph));
	g->graph = graph;
	g->running = intToLongMatrix(graph);
	g->nextOrder = 0;
	g->order = createArray(size(g));
	for(int i = 0; i < size(g); i++){
		g->order[i] = 0;
	}
	advanceGraph(g);
	return g;
}

long getNextValue(Graph* g){
	int index = getOrder(g->order, g->nextOrder);
	long result = g->running[index][index];
	g->nextOrder++;
	if (g->nextOrder >= xMatrix(g->graph)){
		g->nextOrder = 0;
		advanceGraph(g);
	}
	return result;
}

int main(){
	int** g = createMatrix(7, 7);
	for (int i = 0; i < 49; i++){
		g[i/7][i%7] = rand() % 2 * (i/7 != i%7);
		g[i%7][i/7] = g[i/7][i%7];
	}
	printMatrix(g);

	Graph* graph = createGraph(g);

	for (int i = 0; i < 70; i++){
		printf("%ld\n",getNextValue(graph));
	}
}