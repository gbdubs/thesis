crg = copathsRandomGenerator(.4);
graphs = crg.generate(10, 1000);
[uniqueGraphs, counts] = processListOfPossiblyIsomorphicGraphs(graphs);
for i = 1 : size(graphs, 3)
    A = graphs(:,:,i);
    visualizeGraphPaths(A, ['Unique CoPathsAttempt ',num2str(i)], 0); 
end