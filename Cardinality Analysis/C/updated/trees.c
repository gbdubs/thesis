#include <stdio.h>
#include <string.h>
#include <math.h>
#include <stdlib.h>
#include "paths.h"
#include "trees.h"
#include "utilities.h"
#include "structures.h"

/* * * * * * * * * * * * * * * * * * * * */
/*             NODE STRUCTURE            */
/* * * * * * * * * * * * * * * * * * * * */

int nodeId = 0;

typedef struct PathsTreeNode{
	Data* data;
	int height;
	int power;
	int alreadyAdvanced;
	int id;
	struct PathsTreeNode* right;
	struct PathsTreeNode* left;
	struct PathsTreeNode* parent;
} Node;

Node* createNode(Data* data, int power){
	Node *node = malloc(sizeof(Node));
	node->data = data;
	node->height = 0;
	node->power = power;
	node->right = NULL;
	node->left = NULL;
	node->parent = NULL;
	node->id = nodeId++;
	return node;
}

void destroyNode(Node* node){
	destroyData(node->data);
	free(node);
}

/* * * * * * * * * * * * * * * * * * * * */
/*            ROOTS STRUCTURE            */
/* * * * * * * * * * * * * * * * * * * * */

/* * * * * * * * * * * * * * * * * * * * */
/*       EDIT HERE TO ALLOW ANY P        */
				Node* roots[50];
/*                                       */
/* * * * * * * * * * * * * * * * * * * * */

/* * * * * * * * * * * * * * * * * * * * */
/*                PRINTING               */
/* * * * * * * * * * * * * * * * * * * * */

void printTab(int j){
	for (int i = j; i > 0; i--){
		printf("\t");
	}
}

void printNode(Node* node, int i){
	if (node->left != NULL){
		printNode(node->left, i+1);
	}
	printTab(i); printf("NODE %d [%d] \n", node->id, node->height);
	if (node->right != NULL){
		printNode(node->right, i+1);
	}
}

void printAllData(Node* node){
	printf("NODE [%d] {\n", node->id);
	if (node->left != NULL) printf("\tLEFT [%d]\n", node->left->id);
	if (node->right != NULL) printf("\tRIGHT [%d]\n", node->right->id);
	if (node->parent != NULL) printf("\tPARENT [%d]\n", node->parent->id);
	//printf("POWER [%d]\n", node->power);
	//printf("GRAPH: \n");
	//printMatrix(node->data->graph);
	//printf("PATHS: \n");
	//printMatrixL(node->data->paths);
	printf("}\n");
	if (node->left != NULL){
		printAllData(node->left);
	}
	if (node->right != NULL){
		printAllData(node->right);
	}
}

void printTree(int i){
	printNode(roots[i], 0);
	printAllData(roots[i]);
}

/* * * * * * * * * * * * * * * * * * * * */
/*                 WEIGHT                */
/* * * * * * * * * * * * * * * * * * * * */

int weight(Node* node){
	int leftWeight = 0;
	if (node->left != NULL){
		leftWeight = weight(node->left);
	}
	int rightWeight = 0;
	if (node->right != NULL){
		rightWeight = weight(node->right);
	}
	return leftWeight + rightWeight + 1;
}


/* * * * * * * * * * * * * * * * * * * * */
/*                 HEIGHT                */
/* * * * * * * * * * * * * * * * * * * * */

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
	if (node == NULL){
		return;
	}
	int prevHeight = node->height;
	int newHeight = max(getLeftHeight(node), getRightHeight(node)) + 1;
	node->height = newHeight;
	adjustTreeHeight(node->parent);
}

/* * * * * * * * * * * * * * * * * * * * */
/*               ROTATIONS               */
/* * * * * * * * * * * * * * * * * * * * */

int getBalanceFactor(Node *node){
	return getLeftHeight(node) - getRightHeight(node);
}

void rotateTreeLeft(Node *p){
	// printf("perfomring a rotation on node [%d]\n", p->id);
	int power = p->power;

	Node *q = p->right;
	Node *b = q->left;
	Node *a = p->parent;
	
	// if ((p == roots[power]) != (a == NULL)){
		// printf("CONTRADITICTION!!!!\n");
		// printTrees();
	// }

	q->left = p;
	p->parent = q;
	
	if (a == NULL){
		roots[power] = q;
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

	// printf("pointer reassignments successful\n");

	adjustTreeHeight(p);
	adjustTreeHeight(q);
}

void rotateTreeRight(Node *q){
	// printf("perfomring a rotation on node [%d]\n", q->id);
	int power = q->power;

	Node *p = q->left;
	Node *b = p->right;
	Node *a = q->parent;

	// if ((q == roots[power]) != (a == NULL)){
		// printf("CONTRADITICTION!!!!\n");
		// printTrees();
	// }

	p->right = q;
	q->parent = p;
	

	if (a == NULL){
		roots[power] = p;
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

	// printNode(p, 1);
}

int considerARotation(Node *node){
	if (node == NULL){
		return 0;
	}

	int bf = getBalanceFactor(node);
	// printf("CONSIDERING A ROTATION, [%d h=%d] BF = %d\n", node->id, node->height, bf);
	// if (node->parent != NULL) printf(" -- Parent = [%d]\n", node->parent->id);
	if (bf > 1){
		
		if (getBalanceFactor(node->left) < 0){
			rotateTreeLeft(node->left);
		}
		rotateTreeRight(node);
		return 1;
	} else if (bf < -1){
		if (getBalanceFactor(node->right) > 0){
			// printf("double\n");
			rotateTreeRight(node->right);
			// printf("rotated right\n");
		}
		rotateTreeLeft(node);
		// printf("rotated left");
		return 1;
	}
	return considerARotation(node->parent);
}

/* * * * * * * * * * * * * * * * * * * * */
/*              INSERTIONS               */
/* * * * * * * * * * * * * * * * * * * * */

Node* insertIntoSubTreeSet(Node *subRoot, Node *toInsert){
	int comparison = compareData(subRoot->data, toInsert->data);
	// printf("Comparing nodes %d and %d with result %d in tree %d\n", subRoot->id, toInsert->id, comparison, toInsert->power);

	int doPrint = (subRoot->id == 126 && toInsert->id == 178);

	if (comparison == -1){
		if (subRoot->left == NULL){
			subRoot->left = toInsert;
			toInsert->parent = subRoot;
			return NULL;
		} else {
			return insertIntoSubTreeSet(subRoot->left, toInsert);
		}
	}
	if (comparison == 1){
		if (subRoot->right == NULL){
			subRoot->right = toInsert;
			toInsert->parent = subRoot;
			return NULL;
		} else {
			return insertIntoSubTreeSet(subRoot->right, toInsert);
		}
	}
	// Found a duplicate
	return subRoot;
}

void insertIntoPowerTrees(Data* data, int power){
	if (power > 10){
		printf("POWER!!! %d!!!\n", power);
	}

	Node *node = createNode(data, power);

	//printf("--Initializing insert with node [%d]--\n", node->id);

	if (roots[power] == NULL){
		roots[power] = node;
		return;
	} 
	
	Node* otherNode = insertIntoSubTreeSet(roots[power], node);

	// If the returned value is null, then we inserted without colliding.
	// Count yourself lucky, and rebalance the tree if necessary.
	if (otherNode == NULL){
		adjustTreeHeight(node->parent);
		considerARotation(node);
	} else {
		// printf("FOUND COLLISION\n");
		// Nothing inserted into the tree, so don't rebalance or adjust heights.
		if (otherNode->alreadyAdvanced == 0){
			// printf("OTHER ONE NEEDED INSERTING\n");
			// We haven't advanced the collided node!  Mark it collided, and advance it
			otherNode->alreadyAdvanced = 1;
			
			Data* newData = duplicatePathsOneValue(otherNode->data);
			
			insertIntoPowerTrees(newData, power+1);
		} else {
			// printf("OTHER DIDNT NEED INSERTION\n");
		}
		// Advance the inserting node.
		Data* newData = duplicatePathsOneValue(data);
		// printf("DUPLICATED PATHS\n");
		insertIntoPowerTrees(newData, power+1);
	}

}


/* * * * * * * * * * * * * * * * * * * * */
/*                RESULTS                */
/* * * * * * * * * * * * * * * * * * * * */

void printResults(){
	printf("Tree Sizes: ");
	
	int index = 0;
	while (roots[index] != NULL){
		printf("%d\t", weight(roots[index]));
		index++;
	}
	printf("\n");
}

void printTrees(){
	printf("Trees: ");
	
	int index = 0;
	while (roots[index] != NULL){
		printf("=============== TREE #%d ==============\n", index);
		printTree(index++);
	}
	printf("\n");
}

int maxPower(){
	int index = 0;
	while (roots[index] != NULL){
		index++;
	}
	return index + 1;
}

