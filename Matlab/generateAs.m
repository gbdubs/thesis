function [ output_args ] = generateAs( graph )

    n = length(graph);
    runningVariable = graph;

    runUntil = n * 2;
    
    result = zeros(n, runUntil);
    for i = 1 : runUntil
        for j = 1 : n
            result(j, i) = runningVariable(1, j);
        end
        runningVariable = runningVariable * graph;
    end

    output_args = result;




end

