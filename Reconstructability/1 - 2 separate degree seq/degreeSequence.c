#include "graph6.h"
#include "structures.h"

void sortArray(int* a){
	int madeSwap = 1;
	int size = lengthArray(a);
	while(madeSwap){
		madeSwap = 0;
		for(int i = 0; i < size-1; i++){
			if (a[i] > a[i+1]){
				int temp = a[i];
				a[i] = a[i+1];
				a[i+1] = temp;
				madeSwap = 1;
			}
		}
	}
}

int* getDegreeSequence(char s[]){
	int** graph = decodeGraph(s);
	int size = xMatrix(graph);
	int* result = createArray(size);
	for (int i = 0; i < size; i++){
		int total = 0;
		for (int j = 0; j < size; j++){
			total = total + graph[i][j];
		}
		result[i] = total;
	}
	sortArray(result);
	return result;
}

/*
int main(){
	printArray(getDegreeSequence("ICR`uswY_"));
}
*/