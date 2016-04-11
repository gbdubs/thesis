function makeLatexTableForBaselineMetric( metric )

    function [ r ] = generateRow (metric, n, p)
    
        [sN, sMean, sSd] = retrieveFromBaseline(n, p, 'Standard', metric);
        [iN, iMean, iSd] = retrieveFromBaseline(n, p, 'Ideal', metric);
        
        diff = abs(sMean - iMean);
        
        pool = sqrt((sSd ^ 2)/sN + (iSd ^2)/iN);
        
        Z = diff / pool;
        
        r = [' & ', num2str(p),  ' & ', num2str(iMean, '%.3f'), ' & ', num2str(iSd, '%3f'), ' & ', num2str(sMean, '%.3f'), ' & ', num2str(sSd, '%3f'), ' & ' num2str(diff, '%.3f'), ' & ',  num2str(pool, '%3f'),' & ', num2str(Z, '%.3f') , ' \\']; 
        
    end


    disp('\begin{longtable}{ | c | c || c | c | c | c | c | c | c | }');
    disp('\hline');
    disp(['\multicolumn{9}{|c|}{ Baseline Generated for Metric (',metric,')} \\']);
    disp('\hline');
    disp('\multirow{2}{*}{ N } & \multirow{2}{*}{ P } & \multicolumn{2}{| c |}{ Ideal RGG }  & \multicolumn{2}{| c |}{ Gilbert RGG } & \multirow{2}{*}{ $\Delta$ } & \multirow{2}{*}{ $s_{pool}$ } & \multirow{2}{*}{ Z-Score } \\');
    disp('  &  & $\xoverline{x_i}$ & $s_i$ & $\xoverline{x_G}$ & $s_G$ & &  & \\');
    disp(' \hline');
    disp(' \hline');
    disp(' \endhead');
    
    for n = 4 : 10
         disp(['\multirow{9}{*}{',num2str(n),'}', generateRow(metric, n, .1)]);
         for p = .2 : .1 : .9
             disp(generateRow(metric, n, p));
         end
         disp(' \hline');
    end

    disp('\hline');
    disp('\end{longtable}');

end

