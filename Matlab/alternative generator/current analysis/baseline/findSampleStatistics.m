function [ data, n, sampleMean, sampleSD ] = findSampleStatistics( n, p, alg, metric, nGraphs )
    
    pathToData = pathToRandomGraphData(n, p, alg, metric, nGraphs);

    varNames = getAllVariableNamesInFile(pathToData)';

    load(pathToData);
    
    minVarName = randomGraphDataVariableName( metric, n, p, alg, nGraphs);
    
    indices = cell2mat(cellfun(@(y) numel(strfind(y, minVarName)) > 0, varNames, 'un', 0));
    
    varNames = varNames(indices);
    
    data = zeros(numel(varNames), 1);
    
    for i = 1 : numel(varNames)
        varName = cell2mat(varNames(i));
        eval(['temp = ', varName, ';']);
        data(i) = temp;
    end
    
    n = numel(data);
    sampleMean = mean(data);
    sampleSD = std(data);
    
end

