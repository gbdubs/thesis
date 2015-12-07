#include "structures.h"

main(){
	int** a = createMatrix(10, 15);
	printMatrix(a);
	destroyMatrix(a);


}