function [ totalScore ] = scoreAgainstBaseline( alg, n, p )
    
    if nargin < 3
        if nargin < 2
           ts = 0;
           for newN = 4 : 10
               ts = ts + scoreAgainstBaseline(alg, newN);
           end
           totalScore = ts / 7;
           return;
        else
            ts = 0;
            for newP = .1 : .1 : .9
                ts = ts + scoreAgainstBaseline(alg, n, newP);
            end
            totalScore = ts / 9;
            return;
        end
    end


    function [ t ] = tDist(m1, m2, s1, s2, n1, n2)
        t = abs(m1 - m2) / sqrt(s1^2 / n1 + s2^2 / n2);
    end

    metricVariables = {'ADSM';'DSMV';'ADSMD';'DSMDV';'ADSMN';'DSMNV';'ADSMX';'DSMXV';'ADSV';'DSVV';'ADSR';'PQRA';'PQRB';'PQRC';'ODSPL';'ANA';'NCP';'NR';'NE';'PCONN';'ANCC';'NCCV';'ADIAM';'DIAMV';'PTRIL';'ANTRI';'ANQUAD';'ALNA';'MLNA';'VLNA';'NUG';'ANR';'MNR';'SQNR';'PDL'}';

    totalScore = 0;
    definedVars = 0;
    
    for metricCell = metricVariables
        
        metric = cell2mat(metricCell);
        marginalScore = -inf;
        calculatedScoreAgainstBaseline = retrieveScoreAgainstBaseline(alg, n, p, metric);
        
        if (calculatedScoreAgainstBaseline >= -9998)
            
            marginalScore = calculatedScoreAgainstBaseline;
            
        elseif (calculatedScoreAgainstBaseline == -9999)
            
            % Don't do anything, the Score is undefined for this value.
            
        elseif (calculatedScoreAgainstBaseline == -10000)
            [sN, sMean, sSd] = retrieveFromBaseline(n, p, 'Standard', metric);
            [iN, iMean, iSd] = retrieveFromBaseline(n, p, 'Ideal', metric);
            [nN, nMean, nSd] = retrieveFromBaseline(n, p, alg, metric);

            if (iSd > 0 || (sSd > 0 && nSd > 0))
                tIN = tDist(iMean, nMean, iSd, nSd, iN, nN);
                tIG = tDist(iMean, sMean, iSd, sSd, iN, sN);

                marginalScore = -1 * min(log(tIN / tIG + .0000454),10);
                disp(['On Metric [',metric,'], MarginalScore = ', num2str(marginalScore)]);
                saveScoreAgainstBaseline(alg, n, p, metric, marginalScore);
            else
                saveScoreAgainstBaseline(alg, n, p, metric, -9999);
                disp(['UNDEFINED On Metric [',metric,']']);
            end
        end
        
        if (marginalScore > -inf)
            totalScore = totalScore + marginalScore;
            definedVars = definedVars + 1;
        end
    end
    
    totalScore = totalScore / definedVars;
    
end

