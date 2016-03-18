function [ result ] = loadRandomGraphData( n, p, alg, metric, nGraphs )
    pathToTheData = [pwd,'/alternative generator/smalldata/',metric,'/',alg,'_',num2str(n),'.mat'];
    variableName = randomGraphDataVariableName(metric,n,p,alg,nGraphs);
    result = load(pathToTheData, variableName);  
end

