function [ calculatedMetrics ] = findCalculatedMetrics( N, P, ALG, nGraphs )
    
    pathToResults = pathToRandomGraphData(N, P, ALG, -1, 2, 1);
    
    calculatedMetrics = {};
    allMetrics = findAllMetrics();
    
    for i = 1 : numel(allMetrics);
        METRIC = cell2mat(allMetrics(i));
        metricFile = [pwd,'/',pathToResults, '/', METRIC, '/', num2str(nGraphs), '.mat'];
        if exist(metricFile, 'file')
            calculatedMetrics = horzcat(calculatedMetrics, {METRIC});
        end
    end
end

