#include "utilities.h"

/* * * * * * * * * * * * * * * * * * * * */
/*            MATH UTILITIES             */
/* * * * * * * * * * * * * * * * * * * * */

int max(int a, int b){
	if (a < b){
		return b;
	}
	return a;
}

int min(int a, int b){
	if (a > b){
		return b;
	}
	return a;
}