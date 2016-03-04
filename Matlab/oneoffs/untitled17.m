crg = copathsRandomGenerator(.4);
graphs = crg.generate(10, 1000);
for i = 1 : size(graphs, 3)
    A = graphs(:,:,i);
    visualizeGraphPaths(A, ['CoPaths Generation Attempt ',num2str(i)], 0); 
end