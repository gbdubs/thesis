function saveRandomGraphDataResult( result, n, p, alg, metric, nGraphs)

    variableName = randomGraphDataVariableName(metric,n,p,alg,nGraphs);
    
    eval([variableName,' = result;']); 
    
    pathToData = pathToRandomGraphData(n,p,alg,metric,nGraphs);
    try
        save(pathToData,variableName,'-append');
    catch
        makeDirectoriesToRandomGraphData(n, p, alg, metric, nGraphs);
        save(pathToData,variableName,'-append');
    end
end

