function [ resultSize, result ] = findNumberOfCoPathsGraphsInCannonicalSet( graphSet )

    allCoPaths = evalin('base', 'v10CoPaths');

    result = intersect(allCoPaths, graphSet, 'rows');
    
    resultSize = size(result, 1);

end

