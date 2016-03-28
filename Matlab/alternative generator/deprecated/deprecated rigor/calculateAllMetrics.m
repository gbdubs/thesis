function calculateAllMetrics( )

    cannonized = getListOfRandomGraphFileNames(1);

    allMetrics = findAllMetrics();
    
    nDataSets = size(cannonized, 1);
    
    for i = 1 : nDataSets
        disp(['Scanning for work... ', num2str(i), '/', num2str(nDataSets)]);
        disp(cannonized(i,:));
        n = cell2mat(cannonized(i, 1));
        p = cell2mat(cannonized(i, 2));
        alg = cell2mat(cannonized(i, 3));
        ng = cell2mat(cannonized(i, 4));
        alreadyCalculated = findCalculatedMetrics(n,p,alg,ng);
        
        toCalculate = setdiff(allMetrics, alreadyCalculated);
        
        while numel(toCalculate) > 0
            metric = cell2mat(toCalculate(1));
            disp(randomGraphDataVariableName(metric, n, p, alg, ng));
            justCalculated = calculateMetric(metric, n, p, alg, ng);
            toCalculate = setdiff(toCalculate, justCalculated);
        end
    end
end

