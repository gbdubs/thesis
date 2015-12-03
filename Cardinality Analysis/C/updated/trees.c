#include <stdio.h>
#include <string.h>
#include <math.h>
#include <stdlib.h>
#include "paths.h"
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
	printTab(i); printf("NODE [%d]\n", node->id);
	if (node->right != NULL){
		printNode(node->right, i+1);
	}
}

void printAllData(Node* node){
	printf("NODE [%d] {\n", node->id);
	printf("GRAPH: \n");
	printMatrix(node->data->graph);
	printf("PATHS: \n");
	printMatrixL(node->data->paths);
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
	if (newHeight != prevHeight){
		adjustTreeHeight(node->parent);
	}
}

/* * * * * * * * * * * * * * * * * * * * */
/*               ROTATIONS               */
/* * * * * * * * * * * * * * * * * * * * */

int getBalanceFactor(Node *node){
	return getLeftHeight(node) - getRightHeight(node);
}

void rotateTreeLeft(Node *p){
	int power = p->power;

	Node *q = p->right;
	Node *b = q->left;
	Node *a = p->parent;

	q->left = p;
	p->parent = q;
	if (p == roots[power]){
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

	adjustTreeHeight(p);
	adjustTreeHeight(q);
}

void rotateTreeRight(Node *q){
	int power = q->power;

	Node *p = q->left;
	Node *b = p->right;
	Node *a = q->parent;

	p->right = q;
	q->parent = p;
	if (q == roots[power]){
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
}

int considerARotation(Node *node){
	if (node == NULL){
		return 0;
	}
	int bf = getBalanceFactor(node);
	printf("CONSIDERING A ROTATION, [%d h=%d] BF = %d\n", node->id, node->height, bf);
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
	return considerARotation(node->parent);
}

/* * * * * * * * * * * * * * * * * * * * */
/*              INSERTIONS               */
/* * * * * * * * * * * * * * * * * * * * */

Node* insertIntoSubTreeSet(Node *subRoot, Node *toInsert){
	int comparison = compareData(subRoot->data, toInsert->data);
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
	return subRoot;
}

void insertIntoPowerTrees(Data* data, int power){
	printf("CREATING NODE\n");
	Node *node = createNode(data, power);
	printNode(node, 0);
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
		// Nothing inserted into the tree, so don't rebalance or adjust heights.
		if (otherNode->alreadyAdvanced == 0){
			// We haven't advanced the collided node!  Mark it collided, and advance it
			otherNode->alreadyAdvanced = 1;
			Data* newData = duplicatePathsOneValue(otherNode->data);
			insertIntoPowerTrees(newData, power+1);
		}
		// Advance the inserting node.
		Data* newData = duplicatePathsOneValue(data);
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

