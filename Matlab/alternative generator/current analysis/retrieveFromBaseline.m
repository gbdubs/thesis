function [ sampleN, sampleMean, sampleSD ] = retrieveFromBaseline( n, p, alg, metric )
    p = floor (p * 100);
    baseName = [metric,'_',num2str(n), '_', num2str(p),'_',alg];

    sampleN = getfield(load('alternative generator/data/baselineMetrics', [baseName, '_N']), [baseName, '_N']);
    sampleSD = getfield(load('alternative generator/data/baselineMetrics', [baseName, '_SD']), [baseName, '_SD']);
    sampleMean = getfield(load('alternative generator/data/baselineMetrics', [baseName, '_MEAN']), [baseName, '_MEAN']);
    
end