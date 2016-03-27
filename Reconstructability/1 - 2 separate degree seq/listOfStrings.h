/* * Include Guards * * */
#ifndef LISTOFSTRINGS_H_INCLUDED
#define LISTOFSTRINGS_H_INCLUDED
/* * Include Guards * * */

typedef struct ListOfGraphs{
	char* myStr;
	int* degreeSequence;
	int size;
	struct ListOfGraphs* next;
} LOS;

LOS* newListOfGraphs(char* s, int* ds);

LOS* addToListOfGraphs(LOS* los, char* s, int* ds);

void printListOfGraphs(LOS* los);

#endif