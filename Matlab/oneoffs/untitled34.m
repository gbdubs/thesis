metricVariables = {'ADSM';'DSMV';'ADSMD';'DSMDV';'ADSMN';'DSMNV';'ADSMX';'DSMXV';'ADSV';'DSVV';'ADSR';'PQRA';'PQRB';'PQRC';'ODSPL';'ANA';'NCP';'NR';'NE';'PCONN';'ANCC';'NCCV';'ADIAM';'DIAMV';'PTRIL';'ANTRI';'ANQUAD';'ALNA';'MLNA';'VLNA';'NUG';'ANR';'MNR';'SQNR';'PDL'};

for metric =  metricVariables
    m = cell2mat(metric);
    makeLatexTableForAlgorithmComparison(m, 'MinusOne');
end