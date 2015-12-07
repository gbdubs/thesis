/* * * Include Guards * * * */
#ifndef TRIE_H_INCLUDED
#define TRIE_H_INCLUDED
/* * * Include Guards * * * */

#include "graph.h"

/* * * * * * * * * * * * * * * * * * * * */
/*                 TRIES                 */
/* * * * * * * * * * * * * * * * * * * * */

typedef struct TrieNode {
	Graph* graph;
	ListL* values;
	ListV* ptrs;
	int id;
} Node;

int height(Node *n);

void printTrie(Node* n, int tabs);

Node* createRoot();

Node* createNode(Graph* g);

void insert(Node* root, Graph* g);

#endif