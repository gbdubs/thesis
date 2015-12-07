/*

This file is meant as a repository for code that is not being used
in production, but is a good reflection of its use cases/verifications.

VerifyDemonGraphsInfinite, when run, SHOULD throw a segmentation fault
when it overruns the heap.

The others should give us an idea that the Tries are well formed.

*/


void verifyDemonGraphsInfinite(){
	int demon1[] = {0, 0, 0, 0, 1, 1, 0, 0, 1, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 1, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 1, 0, 0, 0, 0, 1, 1, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 1, 0, 1, 0, 1, 0, 1, 0, 0, 1, 0, 1, 1, 0, 0, 1, 1, 0, 1, 0};
	int demon2[] = {0, 0, 0, 0, 1, 1, 0, 0, 1, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 1, 1, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 1, 0, 1, 0, 1, 0, 1, 0, 0, 1, 0, 1, 0, 1, 1, 0, 1, 0, 1, 0};

	int size = 10;

	Node* root = createRoot();

	int** a = createMatrix(size, size);
	int** b = createMatrix(size, size);
	
	for (int i = 0; i < size*size; i++){
		a[i/size][i%size] = demon1[i];
		b[i/size][i%size] = demon2[i];
	}

	printMatrix(a);
	printMatrix(b);

	Graph* gA = createGraph(a);
	Graph* gB = createGraph(b);

	insert(root, gA);
	printf("Inserted 1 successfully\n");
	insert(root, gB);
	printf("Inserted 2 successfully\n");
	printTrie(root, 0);
	
}



void verifyTrieBasics(){
	int size = 5;

	Node* root = createRoot();

	for(int graphs = 0; graphs < 5; graphs++){
		
		int** a = createMatrix(size, size);
		
		for (int i = 0; i < size*size; i++){
			a[i/size][i%size] = rand() % 2 * (i/size != i%size);
			a[i%size][i/size] = a[i/size][i%size];
		}

		printMatrix(a);

		Graph* g = createGraph(a);

		insert(root, g);

		printTrie(root, 0);
	}
}


void verifyGraphGenerator(){
	int size = 10;

	int** g = createMatrix(size, size);
	for (int i = 0; i < size*size; i++){
		g[i/size][i%size] = rand() % 2 * (i/size != i%size);
		g[i%size][i/size] = g[i/size][i%size];
	}

	printMatrix(g);

	Graph* graph = createGraph(g);

	for (int i = 0; i < size * 10; i++){
		printf("%ld\n", getNextValue(graph));
	}
}