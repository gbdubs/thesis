function saveRandomGraphResultData( data, VAR, N, P, ALG, NGRAPHS)

    pathToResults = pathToRandomGraphData(N, P, ALG, -1, 2, 1);
    variableFolder = [pathToResults, '/', VAR];
    
    if ~exist(variableFolder, 'dir')
        mkdir(variableFolder);
    end
    
    variableName = randomGraphDataVariableName(VAR, N, P, ALG, NGRAPHS);
    
    eval([variableName,' = data;']);
    
    filePath = [variableFolder, '/', num2str(NGRAPHS)];
    
    save(filePath, variableName);

end

