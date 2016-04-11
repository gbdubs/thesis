#include <stdio.h>
#include <string.h>
#include <math.h>
#include <stdlib.h>
#include "structures.h"
#include "graph6.h"


int countBits(int i){
	int result = 0;
	while (i > 0){
		result += (i & 1);
		i >> 1;
	}
	return result;
}

ListI* getAllSeeds(int maxSeed, int nBits){
	ListI* list = createListI();
	for (int i = 0; i <= maxSeed; i++){
		if (countBits(i) == nBits){
			insertListI(list, i);
		}
	}
	return list;
}



char* generateParent(int** A, int seed){
	
	int n = xMatrix(A);

	int** parent = createMatrix(n+1, n+1);
	
	for(int i = 0; i < n; i++){
		for(int j = 0; j < n; j++){
			parent[i][j] = A[i][j];
		}
	}
	
	for (int i = 0; i < n; i++){
		int temp = seed & 1;
		parent[i][n] = temp;
		parent[n][i] = temp;
		seed >> 1;
	}
	
	char* encoding = encodeGraph(parent);
	
	destroyMatrix(parent);
	
	return encoding;
}



void addDegreeSequences(int* space, int** A){
	int n, i, j, t, min;

	n = xMatrix(A);
	for(i = 0; i < n; i++){
		t = 0;
		for (j = 0; j < n; j++){
			t += A[i][j];
		}
		space[i] = t;
		space[n+i] = t;
	}
	
	
	for(i = 0; i < n-1; i++){
		min = i;
		for (j = i+1; j < n; j++){
			if (space[j] < space[min]){
				min = j;
			}
		}
		t = desc[min]
		space[min] = desc[i];
		desc[i] = t;
	}
	
}

void addSubgraphDegreeSequences(int* desc, int** A){
	
}

int* generateInitialDescription(int** A){
	
	int n = xMatrix(
	int* array = createArray(int n);
	
	
	
	
}