crg = copathsRandomGenerator(.4);
graphs = crg.generate(10, 1000);
[uniqueGraphs, counts] = processListOfPossiblyIsomorphicGraphs(graphs);
for i = 1 : size(uniqueGraphs, 3)
    A = uniqueGraphs(:,:,i);
    visualizeGraphPaths(A, ['Unique CoPathsAttempt ',num2str(i)], 0); 
end