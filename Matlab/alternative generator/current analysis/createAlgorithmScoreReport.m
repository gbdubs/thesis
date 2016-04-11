function createAlgorithmScoreReport( algorithm )
    
    filename = ['alternative generator/score reports/', algorithm, ' score report.txt'];
    diary on;

    diary (filename);
    disp('\documentclass[11pt,a4paper]{report}');

    disp('\usepackage{mathtools, amsmath, listings, graphicx, amssymb, nth, cite,multirow,longtable,hyperref}');
    disp('\usepackage[utf8]{inputenc}');
    disp('\usepackage[table]{xcolor}');

    disp('\begin{document}');
    disp(['\chapter{Detailed Report For ',algorithm,'}']);
    

    metricVariables = {'ADSM';'DSMV';'ADSMD';'DSMDV';'ADSMN';'DSMNV';'ADSMX';'DSMXV';'ADSV';'DSVV';'ADSR';'PQRA';'PQRB';'PQRC';'ODSPL';'ANA';'NCP';'NR';'NE';'PCONN';'ANCC';'NCCV';'ADIAM';'DIAMV';'PTRIL';'ANTRI';'ANQUAD';'ALNA';'MLNA';'VLNA';'NUG';'ANR';'MNR';'SQNR';'PDL'};

    for m = 1 : numel(metricVariables)
        metric = metricVariables{m};
        makeLatexTableForAlgorithmComparison(metric, algorithm);
    end
    
    disp(['\chapter{Overall Report For ',algorithm,'}']);

    displayLatexScoreResultsAcrossAggregates( algorithm )
    
    disp('\end{document}');
    
    diary off;

end

