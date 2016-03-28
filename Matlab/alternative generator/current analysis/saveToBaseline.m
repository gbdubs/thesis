function saveToBaseline( n, p, alg, metric, sampleN, sampleMEAN, sampleSD )
    p = floor (p * 100);
    baseName = [metric,'_',num2str(n), '_', num2str(p),'_',alg];
    
    eval([baseName, '_N = sampleN;']);
    eval([baseName, '_MEAN = sampleMEAN;']);
    eval([baseName, '_SD = sampleSD;']);
    
    save('alternative generator/data/baselineMetrics', [baseName, '_N'], '-append');
    save('alternative generator/data/baselineMetrics', [baseName, '_MEAN'], '-append');
    save('alternative generator/data/baselineMetrics', [baseName, '_SD'], '-append');
end