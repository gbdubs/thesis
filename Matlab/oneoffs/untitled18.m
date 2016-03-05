nTrials = 100;

crg = copathsRandomGenerator(.4);

t = cputime;
for trial = 1 : nTrials
    considerTimeEstimation(t, trial, nTrials, nTrials);
    
    graphs = crg.generate(10, 100);
    [uniqueGraphs, counts] = processListOfPossiblyIsomorphicGraphs(graphs);
    copaths = findCoPaths(uniqueGraphs);
    
    if numel(copaths) > 0
        for i = 1 : numel(copaths)
            indexes = cell2mat(copaths(i));
            for j = 1 : numel(indexes)
                A = graph6(uniqueGraphs(indexes(j),:));
                title = ['CPGTrial ', num2str(trial),'.',num2str(i), '.', num2str(j)];
                visualizeGraphPaths(A, title, 0); 
            end
        end
    end
end