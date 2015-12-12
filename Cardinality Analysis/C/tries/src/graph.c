#include <stdio.h>
#include <string.h>
#include <math.h>
#include <stdlib.h>
#include "ordermapping.h"
#include "graph.h"
#include "structures.h"

/* * * * * * * * * * * * * * * * * * * * */
/*         GRAPH OBJECT UTILITIES        */
/* * * * * * * * * * * * * * * * * * * * */

// Assigns all graphs a universal ID for debugging + printing purposes.
int globalGraphId = 0;


int size(Graph* g){
	return xMatrix(g->graph);
}


/*
 * The important funciton here.  We treat graphs like STREAMS,
 * allowing us to do the minimal amount of computation we need
 * to in order to differentiate graphs in our understanding of
 * them. This is the Stream UPDATE function, which is in charge
 * of updating the structure of the graph object to allow easy
 * future grabbing of data (aka exponentiation of the graph),
 * and calculation of the new order of the vertices, in which 
 * they will be fed back to the stream.
 */
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


/*
 * Gets the next index in our ordering. Since our order is stored with
 * ties, we need to have a mechanism which breaks them in a consistent
 * way without adding additional memory overhead.  We do this with a 
 * somewhat shitty O(n^2) solution, but on a number of Vertices <= 10,
 * it is negligible when compared to the other computational costs. An
 * example set is shown below:
 *   getOrder([0, 5, 2, 2, 4, 0, 5], 1) ==> 5
 *   getOrder([0, 5, 2, 2, 4, 0, 5], 2) ==> 2
 *   getOrder([0, 5, 2, 2, 4, 0, 5], 6) ==> 6
 */
int getOrder(int* order, int request){
	int length = lengthArray(order);

	int lessThan = 0;
	for(int offset = 0; offset < length; offset++){
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

/*
 * Instantiates a Graph Object, which contains an ID, a running total,
 * and structures that support the stream generation of future values.
 */
Graph* createGraph(int** graph){
	Graph* g = malloc(sizeof(Graph));
	g->id = globalGraphId++;
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


/*
 * The client code for the stream.  Relies heavily on the functionality
 * created by getOrder and advance Graph in order to do the heavy lifting
 * for stream generation.
 */
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