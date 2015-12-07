#include <stdio.h>
#include <string.h>
#include <math.h>
#include <stdlib.h>
#include "ordermapping.h"

int compareOrderMapElements(OM* o, OM* m);


/*
 * A Structure to allow us to do complex mapping relations,
 * sorts, and inversions, without doing any of those things.
 * Essentially just a row of data in a spreadsheet which can
 * be sorted on certain elements, and assigned a new Order
 * value.
 */
OM* createOM(int oo, int nv, int gi, int no){
	OM* om = malloc(sizeof(OM));
	om->oldOrder = oo;
	om-> newValue = nv;
	om->graphIndex = gi;
	om->newOrder = no;
	return om;
}


/*
 * Sorts an order mapping using the comparison function, then
 * assigns each their new ranking.  A pretty integral part of
 * this overall program, I have thoroughly tested it.
 */ 
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


/*
 * Compares OrderMap Elements, ranking Old Order, then New Value, 
 * and returning 0 if they agree on both
 */ 
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


/*
 * Prints Object Mapping elements in a matrix format, so that 
 * their connection to columnar data can be readily described.
 */ 
void printOMs(OM* oms[], int n){
	printf("OO [");
	for (int i = 0; i < n; i++){
		printf("%d\t", oms[i]->oldOrder);
	}
	printf("]\n");
	printf("NV [");
	for (int i = 0; i < n; i++){
		printf("%d\t", oms[i]->newValue);
	}
	printf("]\n");
	printf("GI [");
	for (int i = 0; i < n; i++){
		printf("%d\t", oms[i]->graphIndex);
	}
	printf("]\n");
	printf("NO [");
	for (int i = 0; i < n; i++){
		printf("%d\t", oms[i]->newOrder);
	}
	printf("]\n\n");
}
