function [metricsCalculated] = calculateMetric( metric, n, p, alg, nGraphs )

    inputPath = pathToRandomGraphData(n,p,alg,nGraphs,1,0);
    
    load(inputPath);
    
    files = dir('alternative generator/metrics/')';

    broadMetricName = '';
    for file = files
        if numel(strfind(file.name, '._')) == 0
            fileName = strrep(file.name, '.m', '');
            fileName = strrep(fileName, '.', '');
            if numel(fileName) > 0
                padded = ['_',fileName,'_'];
                if strfind(padded, ['_',metric,'_'])
                    broadMetricName = fileName;
                end
            end
        end
    end
    
    command = ['[', strrep(broadMetricName, '_', ', '),' ] = ',broadMetricName,'(graphSet);'];
    eval(command);
    
    individualMetrics = strsplit(broadMetricName, '_'); 
    for i = 1 : numel(individualMetrics)
        m = cell2mat(individualMetrics(i));
        cmd = ['saveRandomGraphResultData(', m, ', ''',m ''', n, p, alg, nGraphs);'];
        eval(cmd);
    end
    
    metricsCalculated = individualMetrics;
end

