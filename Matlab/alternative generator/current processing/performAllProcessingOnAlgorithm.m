function performAllProcessingOnAlgorithm( algorithm )

    masterCalculator;
    masterCalculator;
    
    metricVariables = {'ADSM';'DSMV';'ADSMD';'DSMDV';'ADSMN';'DSMNV';'ADSMX';'DSMXV';'ADSV';'DSVV';'ADSR';'PQRA';'PQRB';'PQRC';'ODSPL';'ANA';'NCP';'NR';'NE';'PCONN';'ANCC';'NCCV';'ADIAM';'DIAMV';'PTRIL';'ANTRI';'ANQUAD';'ALNA';'MLNA';'VLNA';'NUG';'ANR';'MNR';'SQNR';'PDL'};

    for i = 1 : numel(metricVariables)
        metric = metricVariables{i};
        disp(['Currently baselining/processing metric ', metric]);
        for n = 4 : 10
            for p = .1 : .1 : .9
                [~, sampleN, sampleMean, sampleSD ] = findSampleStatistics( n, p, algorithm, metric, 1000 );
                saveToBaseline(n, p, algorithm, metric, sampleN, sampleMean, sampleSD);
            end
        end
    end

    scoreAgainstBaseline(algorithm);
    
    createAlgorithmScoreReport(algorithm);
    
end

