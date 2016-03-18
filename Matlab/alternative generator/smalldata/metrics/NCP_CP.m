function [ nCoPathsGraphs, coPathsGraphs ] = findNumberOfCoPathsGraphsInCannonicalSet( graphSet )

    % NCP = Number of Copaths Graphs
    % CPG = Copaths Graphs

    allCoPaths = evalin('base', 'v10CoPaths');

    coPathsGraphs = intersect(allCoPaths, graphSet, 'rows');
    
    nCoPathsGraphs = size(coPathsGraphs, 1);

end

