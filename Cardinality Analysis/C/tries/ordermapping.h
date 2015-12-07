/* * * Include Guards * * * */
#ifndef ORDERMAPPING_H_INCLUDED
#define ORDERMAPPING_H_INCLUDED
/* * * Include Guards * * * */

/* * * * * * * * * * * * * * * * * * * * */
/*             ORDER MAPPING             */
/* * * * * * * * * * * * * * * * * * * * */

typedef struct OrderMap {
	int oldOrder;
	int newValue;
	int graphIndex;
	int newOrder;
} OM;

OM* createOM(int oo, int nv, int gi, int no);

int compareOrderMapElements(OM* o, OM* m);

void printOMs(OM* oms[], int n);

void sortOrderMap(OM* oms[], int n);

#endif