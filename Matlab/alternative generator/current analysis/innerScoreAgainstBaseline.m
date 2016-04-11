function [ score ] = innerScoreAgainstBaseline( iMean, iSd, iN, sMean, sSd, sN, aMean, aSd, aN )
    function [ t ] = tDist(m1, m2, s1, s2, n1, n2)
        t = abs(m1 - m2) / sqrt(s1^2 / n1 + s2^2 / n2);
    end

    tIA = tDist(iMean, aMean, iSd, aSd, iN, aN);
    tIG = tDist(iMean, sMean, iSd, sSd, iN, sN);
    
    if iSd > 0 || (sSd > 0 && aSd > 0)
        score = -1 * min(log(tIA / tIG + .0000454),10);
    else
        score = 0;
    end
end

