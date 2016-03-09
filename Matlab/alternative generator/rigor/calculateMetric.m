function calculateMetric( metric, n, p, alg, nGraphs )
    
    inputPath = pathToRandomGraphData(n,p,alg,nGraphs,1,0);
    
    load(inputPath);
    
    result = [];
    
    if strcmp(metric,'UG') == 1
        [result, ~, ~, ~] = UG_FC_FFV_FFC(graphSet);
    elseif strcmp(metric,'FC') == 1
        [~, result, ~, ~] = UG_FC_FFV_FFC(graphSet);
    elseif strcmp(metric,'FFV') == 1
        [~, ~, result, ~] = UG_FC_FFV_FFC(graphSet);
    elseif strcmp(metric,'FFC') == 1
        [~, ~, ~, result] = UG_FC_FFV_FFC(graphSet);
    
    elseif strcmp(metric,'NR') == 1
        [result] = NR(graphSet);
        
    elseif strcmp(metric,'NCP') == 1
        [result, ~] = NCP_CP(graphSet);
    elseif strcmp(metric,'CP') == 1
        [~, result] = NCP_CP(graphSet);
    
    elseif strcmp(metric,'NA') == 1
        [result, ~, ~, ~] = NA_NAC_NAB_ANA(graphSet);
    elseif strcmp(metric,'NA') == 1
        [~, result, ~, ~] = NA_NAC_NAB_ANA(graphSet);
    elseif strcmp(metric,'NA') == 1
        [~, ~, result, ~] = NA_NAC_NAB_ANA(graphSet);
    elseif strcmp(metric,'NA') == 1
        [~, ~, ~, result] = NA_NAC_NAB_ANA(graphSet);
    end
    
    saveRandomGraphResultData(result, metric, n, p, alg, nGraphs);
end

