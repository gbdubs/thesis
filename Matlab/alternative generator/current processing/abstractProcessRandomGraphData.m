function abstractProcessRandomGraphData(metric1, metric2)
    
    rawFileNames = getAllFilePathsWithMetric(metric1, 1);
    cannonFileNames = getAllFilePathsWithMetric(metric2, 1);
    
    index = 1;
    for f = rawFileNames
        fileName = cell2mat(f);
        rawFile = [pwd,'/alternative generator/smalldata/',metric1,'/',fileName];
        cannonFile = [pwd,'/alternative generator/smalldata/',metric2,'/',fileName];
        
        rawVars = getAllVariableNamesInFile(rawFile);
        load(rawFile);
        
        vtc = [];
        vtcnn = [];
        if index <= numel(cannonFileNames) && strcmp(cell2mat(cannonFileNames(index)), fileName)
            cannonVars = getAllVariableNamesInFile(cannonFile);
            [vtc, vtcnn] = findVariablesToCannonize(rawVars, cannonVars, metric1, metric2);
            index = index + 1;
        else
            [vtc, vtcnn] = findVariablesToCannonize(rawVars, cell(0,1), metric1, metric2);
        end
        
        for v = 1 : numel(vtc)
            varName = cell2mat(vtc(v));
            varNewName = cell2mat(vtcnn(v));
            eval(['calculateMetricOverRandomGraphData(metric2, ',varName,', cannonFile, varNewName);']);
        end
    end
end

