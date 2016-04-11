/* * Include Guards * * */
#ifndef LISTOFSTRINGS_H_INCLUDED
#define LISTOFSTRINGS_H_INCLUDED
/* * Include Guards * * */

typedef struct ListOfGraphs{
	char* myStr;
	int** degreeSequenceMatrix;
	int size;
	struct ListOfGraphs* next;
} LOS;

LOS* newListOfGraphs(char* s, int** dsm);

LOS* addToListOfGraphs(LOS* los, char* s, int** dsm);

void printListOfGraphs(LOS* los);

#endif