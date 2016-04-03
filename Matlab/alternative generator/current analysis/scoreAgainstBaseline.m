function [ output_args ] = scoreAgainstBaseline( n, p, alg )
    
    metricVariables = {'ADSM';'DSMV';'ADSMD';'DSMDV';'ADSMN';'DSMNV';'ADSMX';'DSMXV';'ADSV';'DSVV';'ADSR';'PQRA';'PQRB';'PQRC';'ODSPL';'ANA';'NCP';'NR';'NE';'PCONN';'ANCC';'NCCV';'ADIAM';'DIAMV';'PTRIL';'ANTRI';'ANQUAD';'ALNA';'MLNA';'VLNA';'NUG';'ANR';'MNR';'SQNR';'PDL'};

    totalScore = 0;
    
    for metric = metricVariables
        
        temp = load
        
        marginalScore = 
        
        totalScore = totalScore + marginalScore * 1 / numel(metricVariables);
    end
    
    
end

