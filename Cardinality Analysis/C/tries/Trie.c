#include <stdio.h>
#include <string.h>
#include <math.h>
#include <stdlib.h>
#include "structures.h"
#include "graph6.h"
#include "graph.h"
#include "trie.h"
#include "simrecorder.h"


// Assigns all trie nodes a universal ID for debugging + printing purposes.
int globalTrieId = 0;

// Arbitrarily decides that two are "similar" if their paths line up at depth 100.
int maxDepth = 100;

/*
 * Creates a trie node with the given graph (note that this is inherently
 * a leaf node (though it may later be transformed internal if there is a
 * collision)).
 */
Node* createNode(Graph* g){
	Node* n = malloc(sizeof(Node));
	n->graph = g;
	n->parent = NULL;
	n->values = createListL();
	n->ptrs = createListV();
	n->id = globalTrieId++;
	return n;
}

Node* createRoot(){
	return createNode(NULL);
}

int depth(Node*);

/*
 * The meat of this file, the insertion function, follows a pretty classic
 * Trie implementation, with the Lifecycle
 *   - Trie Node is Created with A Graph In It
 *   - If Graph is inserted into node with graph, both graphs are reinserted
 *     into the node, but the graph of the node is now set to NULL.  
 * This means that we have the minimal number of nodes nescessary to ensure
 * that we can differentate between each of the graphs in the trie.
 */
void insert(Node* root, Graph* g){
	if (root->graph != NULL){
		if (depth(root) >= maxDepth){
			recordSimilar(root->graph->graph, g->graph);
			return;
		} 
		Graph* temp = root->graph;
		root->graph = NULL;
		insert(root, temp);
	}
	
	long generated = getNextValue(g);

	int nextIndex = indexOfL(root->values, generated);

	if (nextIndex == -1){
		insertListL(root->values, generated);
		Node* n = createNode(g);
		n->parent = root;
		insertListV(root->ptrs, n);
	} else {
		Node* nextNode = (Node*) root->ptrs->values[nextIndex];
		insert(nextNode, g);
	}
}


/*
 * Finds the height of the Trie rooted at the passed in value.
 */
int height(Node *n){
	if (n == NULL){
		return -1;
	}
	int maxHeight = -1;
	for (int i = 0; i < n->values->size; i++){
		int otherHeight = height((Node*) n->ptrs->values[i]);
		if (maxHeight < otherHeight){
			maxHeight = otherHeight;
		}
	}
	return maxHeight + 1;
}


/*
 * Finds the weight of the Trie rooted at the passed in value.
 */
int weight(Node *n){
	if (n == NULL){
		return 0;
	}
	int totalWeight = 1;
	for (int i = 0; i < n->values->size; i++){
		int otherWeight = weight((Node*) n->ptrs->values[i]);
		totalWeight += otherWeight;
	}
	return totalWeight;
}

/*
 * Finds the depth of the Trie rooted at the passed in value.
 */
int depth(Node *n){
	//printf("Calc depth for n = [%d]\n", n->id);
	if (n->parent == NULL){
		return 0;
	}
	int dep = depth(n->parent) + 1;
	//printf("Calc depth for n = [%d] = [%d]\n", n->id, dep);
	return dep;
}


void printTabs(int n){
	for (int i = 0; i < n; i++){
		printf("\t");
	}
}


void printTrie(Node* n, int tabs){
	printTabs(tabs);
	printf("TRIE NODE [%d]\n",n->id);
	for (int i = 0; i < n->ptrs->size; i++){
		Node* child = (Node*) n->ptrs->values[i];
		printTabs(tabs+1);
		printf("[%ld] -->\n", n->values->values[i]);
		printTrie(child, tabs+1);
	}
}
