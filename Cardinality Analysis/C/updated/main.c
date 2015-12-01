#include <stdio.h>
#include "structures.h"
#include "graph6.h"
#include "paths.h"

int main(){
	int** a = createMatrix(10, 15);
	printMatrix(a);
	destroyMatrix(a);
}