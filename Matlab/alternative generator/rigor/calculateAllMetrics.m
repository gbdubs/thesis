function [ output_args ] = calculateAllMetrics( )

    cannonized = getListOfRandomGraphFileNames(1);

    allMetrics = findAllMetrics();
    
    nDataSets = size(cannonized, 1);
    
    for i = 1 : nDataSets
        n = cell2mat(cannonized(i, 1));
        p = cell2mat(cannonized(i, 2));
        alg = cell2mat(cannonized(i, 3));
        ng = cell2mat(cannonized(i, 4));
        alreadyCalculated = findCalculatedMetrics(n,p,alg,ng);
        
        toCalculate = setdiff(allmetrics, alreadyCalculated);
        
        for j = 1 : numel(toCalculate)
            metric = cell2mat(toCalculate(j));
            calculateMetric(metric, n, p, alg, ng);
        end
    end
end

