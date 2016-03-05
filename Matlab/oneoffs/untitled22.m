nTrials = 1000;

crg = copathsRandomGenerator(.4);
crg.p1G1E = 0;
crg.p2G1E = 0;
crg.p2G2E = 1;

t = cputime;
for trial = 1 : nTrials
    considerTimeEstimation(t, trial, nTrials, 100);
    
    graphs = crg.generate(10, 100);
    [uniqueGraphs, counts] = processListOfPossiblyIsomorphicGraphs(graphs);
    copaths = findCoPaths(uniqueGraphs);
    
    if numel(copaths) > 0
        for i = 1 : numel(copaths)
            indexes = cell2mat(copaths(i));
            for j = 1 : numel(indexes)
                A = graph6(uniqueGraphs(indexes(j),:));
                title = ['CPG2G1E ', num2str(trial),'.',num2str(i), '.', num2str(j)];
                visualizeGraphPaths(A, title, 0); 
            end
        end
    end
end