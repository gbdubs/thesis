#include "paths.h"

/* * * * * * * * * * * * * * * * * * * * */
/*             NODE STRUCTURE            */
/* * * * * * * * * * * * * * * * * * * * */

typedef struct PathsTreeNode{
	Data* data;
	int height;
	int power;
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
	return node;
}

void destroyNode(Node* node){
	destroyData(node->data);
	free(node);
}

/* * * * * * * * * * * * * * * * * * * * */
/*            ROOTS STRUCTURE            */
/* * * * * * * * * * * * * * * * * * * * */

int nRoots = 50;

Node roots[nRoots];



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

Data* insertIntoSubTreeSet(Node *subRoot, Node *toInsert){
	int comparison = compareData(subRoot->data, toInsert->data);
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
	return 0;
}



void insertIntoTrees(Data* data, int power){
	Node *node = createNode(data);
	
	if (root == NULL){
		root = node;
		return 1;
	} 
		
	Data* otherData = insertIntoSubTreeSet(root, node);


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



