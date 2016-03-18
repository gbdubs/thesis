function saveRandomGraphDataResult( result, n, p, alg, metric, nGraphs, runNumber)

    variableName = randomGraphDataVariableName(metric,n,p,alg,nGraphs, runNumber);
    
    eval([variableName,' = result;']); 
    
    pathToData = pathToRandomGraphData(n,p,alg,metric,nGraphs);
    
    try
        save(pathToData,variableName,'-append');
    catch
        metricFolder = [pwd,'/alternative generator/smalldata/',metric];
        
        if ~exist(metricFolder,'dir')
            mkdir(metricFolder);
        end
        
        pathToData = pathToRandomGraphData(n,p,alg,metric,nGraphs);
        
        if ~exist(pathToData,'file')
            save(pathToData,'metric','alg','n');
        end
        
        save(pathToData,variableName,'-append');
    end
end

