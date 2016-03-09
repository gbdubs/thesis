function [ nCoPathsGraphs, coPathsGraphs ] = findNumberOfCoPathsGraphsInCannonicalSet( graphSet )

    allCoPaths = evalin('base', 'v10CoPaths');

    coPathsGraphs = intersect(allCoPaths, graphSet, 'rows');
    
    nCoPathsGraphs = size(coPathsGraphs, 1);

end

