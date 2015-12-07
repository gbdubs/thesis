#include <stdio.h>
#include <string.h>
#include <math.h>
#include <stdlib.h>

int v = 8;
int e = 28;

/* * * * * * * * * * * * * * * * * * * * */
/*            MATH UTILITIES             */
/* * * * * * * * * * * * * * * * * * * * */
int max(int a, int b){
	if (a > b){
		return a;
	}
	return b;
}



/* * * * * * * * * * * * * * * * * * * * */
/*           ARRAY UTILITIES             */
/* * * * * * * * * * * * * * * * * * * * */

int** createMatrix(){
	int* values = malloc(v*v*sizeof(int));
	int** rows = malloc(v*sizeof(int*));
	for (int i = 0; i < v; i++){
		rows[i] = &values[i*v];
	}
	return rows;
}

void destroyMatrix(int** a){
	free(*a);
	free(a);
}

void printArray(int* a){
	printf("[");
	for(int i = 0; i < v; i++){
		if (i == v - 1){
			printf("%d", a[i]);
		} else {
			printf("%d, ", a[i]);
		}
	}
	printf("]\n");
}

void printMatrix(int** a){
	for (int i = 0; i < v; i++){
		printArray(a[i]);
	}
}

int compareVectors(int* a, int* b){
	for (int i = 0; i < v; i++){
		if (a[i] < b[i]){
			return -1;
		}
		if (a[i] > b[i]){
			return 1;
		}
	}
	return 0;
}

// Bubble sorts the matrix vectors; acceptable for n <= 11.
// Also couldn't figure out pointer swapping while still 
// freeing up memory, so had to go with actually manipulating
// the values in the vector, which is incredibly sub-par.
// Speeding up this function is a place where I could get a 
// relatively large time speedup.
int** sortMatrixVectors(int** a){
	for (int i = 0; i < v; i++){
		int madeChange = 0;
		for (int j = 0; j < v-1; j++){
			if (compareVectors(a[j],a[j+1]) == 1){
				madeChange = 1;
				for (int k = 0; k < v; k++){
					int temp = a[j][k];
					a[j][k] = a[j+1][k];
					a[j+1][k] = temp;
				}
			}
		}
		if (madeChange == 0){
			i = v;
		}
	}
	return a;
}



/* * * * * * * * * * * * * * * * * * * * */
/*           MATRIX UTILITIES            */
/* * * * * * * * * * * * * * * * * * * * */

int** multiply(int** a, int** b){
	int** result = createMatrix();
	for (int i = 0; i < v; i++){
		for (int j = 0; j < v; j++){
			int total = 0;
			for (int k = 0; k < v; k++){
				total += a[i][k] * b[k][j];
			}
			result[i][j] = total;
		}
	}
	return result;
}



/* * * * * * * * * * * * * * * * * * * * */
/*         GENERATION UTILITIES          */
/* * * * * * * * * * * * * * * * * * * * */

int* makeVariationNumber(int seed){
	int* result = malloc(sizeof(int) * e); 
	for (int i = 0; i < e; i++){
		result[i] = seed & 1;
		seed = seed >> 1;
	}
	return result;
}

int** createGraph(int seed){
	int** a = createMatrix();
	int* filler = makeVariationNumber(seed);
	int count = 0;
	for (int i = 0; i < v; i++){
		a[i][i] = 0;
		for (int j = i+1; j < v; j++){
			a[i][j] = filler[count];
			a[j][i] = filler[count];
			count++;
		}
	}
	free(filler);
	return a;
}



/* * * * * * * * * * * * * * * * * * * * */
/*                PATHS                  */
/* * * * * * * * * * * * * * * * * * * * */

int** calculatePaths(int** a){
	int** result = createMatrix();
	int** running = multiply(a, a);

	for (int i = 0; i < v; i++){
		for (int j = 0; j < v; j++){
			result[j][i] = running[j][j];
		}
		if (i != v - 1){
			int** oldRunning = running;
			running = multiply(running, a);
			destroyMatrix(oldRunning);
		}
	}
	destroyMatrix(running);
	destroyMatrix(a);
	return result;
}

int comparePaths(int** a, int** b){
	for (int i = 0; i < v; i++){
		int result = compareVectors(a[i], b[i]);
		if (result != 0){
			return result;
		}
	}
	return 0;
}

int** getPathsForSeed(int seed){
	int** g = createGraph(seed);
	int** paths = calculatePaths(g);
	int** result = sortMatrixVectors(paths);
	return result;
	//return paths;
}



/* * * * * * * * * * * * * * * * * * * * */
/*            TREE UTILITIES             */
/* * * * * * * * * * * * * * * * * * * * */

/* * * * * * * * * * * * * * * * * * * * *
This tree is meant to serve as an efficent
tree set.  It does not support deletion or
membership tests, only an addition method
which retruns 0 if the element is alredy 
in the tree.               
* * * * * * * * * * * * * * * * * * * * */

typedef struct PathsTreeNode{
	int id;
	int** pathsResult;
	int height; 
	struct PathsTreeNode* right;
	struct PathsTreeNode* left;
	struct PathsTreeNode* parent;
} Node;

Node* root = NULL;
int nodeId = 0;

int getLeftHeight(Node *node){
	int leftHeight = -1;
	if (node->left != NULL){
		leftHeight = node->left->height;
	}
	return leftHeight;
}

int getRightHeight(Node *node){
	int rightHeight = -1;
	if (node->right != NULL){
		rightHeight = node->right->height;
	}
	return rightHeight;
}

void adjustTreeHeight(Node *node){
	node->height = max(getLeftHeight(node), getRightHeight(node)) + 1;
}

void rotateTreeLeft(Node *p){
	Node *q = p->right;
	Node *b = q->left;
	Node *a = p->parent;

	q->left = p;
	p->parent = q;
	if (p == root){
		root = q;
		p->parent = NULL;
	} else {
		q->parent = a;
		if (a->left == p){
			a->left = q;
		} else if (a->right == p){
			a->right = q;
		}
	}

	p->right = b;
	if (b != NULL){
		b->parent = p;
	}

	adjustTreeHeight(p);
	adjustTreeHeight(q);
}

void rotateTreeRight(Node *q){
	Node *p = q->left;
	Node *b = p->right;
	Node *a = q->parent;

	p->right = q;
	q->parent = p;
	if (q == root){
		root = p;
		p->parent = NULL;
	} else {
		p->parent = a;
		if (a->left == q){
			a->left = p;
		} else if (a->right == q){
			a->right = p;
		}
	}

	q->left = b;
	if (b != NULL){
		b->parent = q;
	}

	adjustTreeHeight(q);
	adjustTreeHeight(p);
}

int getBalanceFactor(Node *node){
	return getLeftHeight(node) - getRightHeight(node);
}

int considerARotation(Node *node){
	int bf = getBalanceFactor(node);
	if (bf > 1){
		if (getBalanceFactor(node->left) < 0){
			rotateTreeLeft(node->left);
		}
		rotateTreeRight(node);
		return 1;
	} else if (bf < -1){
		if (getBalanceFactor(node->right) > 0){
			rotateTreeRight(node->right);
		}
		rotateTreeLeft(node);
		return 1;
	}
	return 0;
}

int insertIntoSubTreeSet(Node *subRoot, Node *toInsert){
	int comparison = comparePaths(subRoot->pathsResult, toInsert->pathsResult);
	if (comparison == -1){
		if (subRoot->left == NULL){
			subRoot->left = toInsert;
			toInsert->parent = subRoot;
			return 1;
		} else {
			return insertIntoSubTreeSet(subRoot->left, toInsert);
		}
	}
	if (comparison == 1){
		if (subRoot->right == NULL){
			subRoot->right = toInsert;
			toInsert->parent = subRoot;
			return 1;
		} else {
			return insertIntoSubTreeSet(subRoot->right, toInsert);
		}
	}

	// Otherwise, the element was already found.
	// Destroy the duplicative structures + memory.
	destroyMatrix(toInsert->pathsResult);
	free(toInsert);

	return 0;
}

Node* createNode(int** paths){
	Node *node = malloc(sizeof(Node));
	node->pathsResult = paths;
	node->height = 0;
	node->right = NULL;
	node->left = NULL;
	node->parent = NULL;
	node->id = nodeId++;
	return node;
}

int insertIntoTreeSet(int** paths){
	Node *node = createNode(paths);
	
	if (root == NULL){
		root = node;
		return 1;
	} 
		
	int result = insertIntoSubTreeSet(root, node);
	if (result == 1){
		Node *temp = node;
		while (temp != NULL){
			adjustTreeHeight(temp);
			if (considerARotation(temp) != 0){
				return result;
			}
			temp = temp->parent;
		}
	}

	return result;
}

void printTree(Node *node){
	printf("NODE (%d) h=%d:\n",node->id,node->height);
	if (node->left != NULL){
		printf("  LEFT = (%d) h=%d\n", node->left->id, node->left->height);
	}
	if (node->right != NULL){
		printf("  RIGHT = (%d) h=%d\n", node->right->id, node->right->height);
	}
	if (node->left != NULL){
		printTree(node->left);
	}
	if (node->right != NULL){
		printTree(node->right);
	}
}




/* * * * * * * * * * * * * * * * * * * * */
/*        GRAPH6 GRAPH CONVERTER         */
/* * * * * * * * * * * * * * * * * * * * */

// Converts a string in Graph6 format to an adjacency
// matrix for manipulation.
// 1) Remove the first character from s (it tells you v)
// 2) For each character, subtract 63, convert into binary
// 3) The bitstring remaining is the upper triangle of
//    the adjacency matrix.  Fill these values in.
int** retrieveGraph(char s[]){
	int** graph = createMatrix();
	int count = 0;
	int index = 1;
	int x = 1;
	int y = 0;
	while (count < e){
		int c = (int) (s[index]) - 63;
		int toAdd[6];
		for(int i = 5; i >= 0; i--){
			toAdd[i] = c % 2;
			c = c >> 1;
		}
		for (int i = 0; i < 6; i++){
			if (x == y){
				graph[x][y] = 0;
				x = x+1;
				y = 0;
				if (x == v){
					return graph;
				}
			}
			graph[x][y] = toAdd[i];
			graph[y][x] = toAdd[i];
			count++;
			y++;
		}
		index++;
	}
	return graph;
}



/* * * * * * * * * * * * * * * * * * * * */
/*              CLIENT CODE              */
/* * * * * * * * * * * * * * * * * * * * */

/* 
Naieve numerical calculator, does not assume that some
tool like NAUTY or other pipes it inputted non-isomorphic
graphs. Was used to verify the veracity of the tree and
paths techniques, which would have failed had they been 
incorrect.
*/
void pathsCardinaltiyNaieve(){
	int iterations = 1 << e;
	int totalNumberUnique = 0;
	for (int i = 0; i < iterations; i++){
		if (i % 10000 == 0 && i > 0){
			printf("%d  %d\n", i, totalNumberUnique);
		}
		int** paths = getPathsForSeed(i);

		int novel = insertIntoTreeSet(paths);

		totalNumberUnique += novel;
	}
	printf("All graphs of size %d were show to have %d unique paths functions.\n", v, totalNumberUnique);
}


/*
Cardinality calculator when given a file containing all
of the graphs of that size in 6Graph Form. Performs the
same operations as above, working to show that two non-
isomorphic graphs could not generate the same paths 
function.
*/

void pathsCardinalityPreComputed(){
	FILE *nautyFile;
	nautyFile = fopen("/Users/Grady/Desktop/nauty25r9/8.txt", "r");
	char inputBuffer[12];
	
	int totalNumberUnique = 0;
	
	int loopCount = 0;
	while (fscanf(nautyFile, "%s", inputBuffer) == 1){
		// Prints an updating statement
		if (loopCount % 1000 == 0){ printf("Processed %d graphs, found %d unique paths functions.\n", loopCount, totalNumberUnique); }

		// Retrieves the graph, calculates its paths function, sorts the vectors, and inserts it into the tree.
		totalNumberUnique += insertIntoTreeSet(sortMatrixVectors(calculatePaths(retrieveGraph(inputBuffer))));

		loopCount++;
	}

	printf("=====================================================\
		   \n    Total number of unique paths functions: %d\
		   \n=====================================================\n", totalNumberUnique);
	
	fclose(nautyFile);
}



/* * * * * * * * * * * * * * * * * * * * */
/*               MAIN METHOD             */
/* * * * * * * * * * * * * * * * * * * * */

int main(){
	pathsCardinalityPreComputed();
}