nTrials = 100;

crg = copathsRandomGenerator(.4);

t = cputime;
for trial = 1 : nTrials
    considerTimeEstimation(t, trial, nTrials, nTrials);
    
    graphs = crg.generate(10, 100);
    [uniqueGraphs, counts] = processListOfPossiblyIsomorphicGraphs(graphs);
    copaths = findCoPaths(uniqueGraphs);
    
    if numel(copaths) > 0
        for i = 1 : size(uniqueGraphs, 3)
            A = graph6(uniqueGraphs(i,:));
            title = ['CPAS Trial ', num2str(trial),' - ',num2str(i)];
            visualizeGraphPaths(A, title, 0); 
        end
    end
end