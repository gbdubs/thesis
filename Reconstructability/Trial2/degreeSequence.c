#include "graph6.h"
#include "structures.h"


int** getDegreeSequenceMatrix(char s[]){
	int** graph = decodeGraph(s);
	int size = xMatrix(graph);
	int** resultMatrix = createMatrix(size, size);

	int* temp = createArray(size);
	for (int k = 0; k < size; k++){
		for (int i = 0; i < size; i++){
			int total = 0;
			for (int j = 0; j < size; j++){
				total = total + graph[i][j];
			}
			if (i != k){
				temp[i] = total - graph[i][k];
			} else {
				temp[i] = 0;
			}
		}
		sortArray(temp);
		for (int i = 0; i < size; i++){
			resultMatrix[k][i] = temp[i];
		}
	}

	sortMatrixRows(resultMatrix);

	destroyArray(temp);

	return resultMatrix;
}

int main(){
	printMatrix(getDegreeSequenceMatrix("ICR`uswY_"));
}