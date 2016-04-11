function displayLatexScoreResultsAcrossAggregates( algorithm )

    metricVariables = {'ADSM';'DSMV';'ADSMD';'DSMDV';'ADSMN';'DSMNV';'ADSMX';'DSMXV';'ADSV';'DSVV';'ADSR';'PQRA';'PQRB';'PQRC';'ODSPL';'ANA';'NCP';'NR';'NE';'PCONN';'ANCC';'NCCV';'ADIAM';'DIAMV';'PTRIL';'ANTRI';'ANQUAD';'ALNA';'MLNA';'VLNA';'NUG';'ANR';'MNR';'SQNR';'PDL'}';

    nMetrics = numel(metricVariables);
    nP = 9;
    nN = 10;
    
    avgAcrossMetric = zeros(nN, nP);
    avgAcrossN = zeros(nMetrics, nP);
    avgAcrossP = zeros(nMetrics, nN);
    
    avgAcrossMetricN = zeros(nP);
    avgAcrossMetricP = zeros(nN);
    avgAcrossNP = zeros(nMetrics);
    
    avgAcrossAll = zeros(1);
    
    progressbar;
    for m = 1 : nMetrics
        progressbar(m / nMetrics);
        metric = metricVariables{m};
        disp(['% Metric = ', metric]);
        for n = 4 : 10
            for p = 1 : 9
                value = retrieveScoreAgainstBaseline(algorithm, n, p/10, metric);
                if (value > -11 && value < 11)
                    avgAcrossMetric(n, p) = avgAcrossMetric(n, p) + value;
                    avgAcrossN(m, p) = avgAcrossN(m, p) + value;
                    avgAcrossP(m, n) = avgAcrossP(m, n) + value;

                    avgAcrossMetricN(p) = avgAcrossMetricN(p) + value;
                    avgAcrossMetricP(n) = avgAcrossMetricP(n) + value;
                    avgAcrossNP(m) = avgAcrossNP(m) + value;

                    avgAcrossAll = avgAcrossAll + value;
                end
            end
        end
    end
    
    avgAcrossMetric = avgAcrossMetric / nMetrics;
    avgAcrossN = avgAcrossN / 7;
    avgAcrossP = avgAcrossP / nP;
    
    avgAcrossMetricN = avgAcrossMetricN / (nMetrics * 7);
    avgAcrossMetricP = avgAcrossMetricP / (nMetrics * nP);
    avgAcrossNP = avgAcrossNP / (nP * 7);
    
    avgAcrossAll = avgAcrossAll / (nP * 7 * nMetrics);
    
    function [ c ] = cellColor(score)
        c = [' \cellcolor[HTML]{',hexNegTenTen(score),'} ',num2str(score, '%.2f')];
    end
    
    %%%%%%%%%%%%%%%%%%%%%%% N X P %%%%%%%%%%%%%%%%%%%%%%%%
    disp('\begin{longtable}{ | c || c | c | c | c | c | c | c || c |}');
    disp('\hline');
    disp(['\multicolumn{9}{|c|}{ ',algorithm,' Score Report: N x P, Averaged Across Metrics } \\']);
    disp('\hline');
    disp('\multicolumn{9}{|c|}{ N } \\');
    disp('\hline');
    disp('P & 4 & 5 & 6 & 7 & 8 & 9 & 10 & Mean\\');
    disp('\hline');
    disp('\hline');
    disp('\endhead');
    for p = 1 : 9
       row = num2str(p/10);
       for n = 4 : 10
           row = [row, ' & ',cellColor(avgAcrossMetric(n, p))];
       end
       disp([row, ' & ', cellColor(avgAcrossMetricN(p)), ' \\']);
    end
    disp('\hline');
    disp('\hline');
    
    row = 'Mean ';
    for n = 4 : 10
        row = [row, ' & ', cellColor(avgAcrossMetricP(n))];
    end
    disp([row, ' & ', cellColor(avgAcrossAll), ' \\']);
  
    disp('\hline');
    disp('\end{longtable}');
    %%%%%%%%%%%%%%%%%%%% METRIC X P %%%%%%%%%%%%%%%%%%%%%%
    
    disp('\begin{longtable}{ | c || c | c | c | c | c | c | c | c | c || c |}');
    disp('\hline');
    disp(['\multicolumn{11}{|c|}{ ',algorithm,' Score Report: P x Metric, Averaged Across N } \\']);
    disp('\hline');
    disp('\multicolumn{11}{|c|}{ P } \\');
    disp('\hline');
    disp('Metric & .1 & .2 & .3 & .4 & .5 & .6 & .7 & .8 & .9 & Mean\\');
    disp('\hline');
    disp('\hline');
    disp('\endhead');
    for m = 1 : nMetrics
       row = metricVariables{m};
       for p = 1 : 9
           row = [row, ' & ',cellColor(avgAcrossN(m, p))];
       end
       disp([row, ' & ', cellColor(avgAcrossNP(m)), ' \\']);
    end
    disp('\hline');
    disp('\hline');
    
    row = 'Mean ';
    for p = 1 : 9
        row = [row, ' & ', cellColor(avgAcrossMetricN(p))];
    end
    disp([row, ' & ', cellColor(avgAcrossAll), ' \\']);
  
    disp('\hline');
    disp('\end{longtable}');
    
    
    
    %%%%%%%%%%%%%%%%%%%% METRIC X N %%%%%%%%%%%%%%%%%%%%%%
    disp('\begin{longtable}{ | c || c | c | c | c | c | c | c || c |}');
    disp('\hline');
    disp(['\multicolumn{9}{|c|}{ ',algorithm,' Score Report: N x Metric, Averaged Across P } \\']);
    disp('\hline');
    disp('\multicolumn{9}{|c|}{ N } \\');
    disp('\hline');
    disp('Metric & 4 & 5 & 6 & 7 & 8 & 9 & 10 & Mean\\');
    disp('\hline');
    disp('\hline');
    disp('\endhead');
    for m = 1 : nMetrics
       row = metricVariables{m};
       for n = 4 : 10
           row = [row, ' & ',cellColor(avgAcrossP(m, n))];
       end
       disp([row, ' & ', cellColor(avgAcrossNP(m)), ' \\']);
    end
    disp('\hline');
    disp('\hline');
    
    row = 'Mean ';
    for n = 4 : 10
        row = [row, ' & ', cellColor(avgAcrossMetricP(n))];
    end
    disp([row, ' & ', cellColor(avgAcrossAll), ' \\']);
  
    disp('\hline');
    disp('\end{longtable}');
end

