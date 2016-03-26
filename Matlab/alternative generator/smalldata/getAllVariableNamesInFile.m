function [ variablesInFile ] = getAllVariableNamesInFile( fileName )
    temp = load(fileName);
    variableNames = fieldnames(temp);
    toExclude = {'n', 'alg', 'metric'};
    variablesInFile = setdiff(variableNames, toExclude);
end

