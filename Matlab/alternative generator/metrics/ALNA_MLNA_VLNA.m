function [ ALNA, MLNA, VLNA ] = ALNA_MLNA_VLNA( n, p, alg, nGraphs )
    % ALNA = Average of Logarithm of Number of Automorphisms.
    % MLNA = Median of Logarithm of Number of Automorphisms.
    % VLNA = Variance of Logarithm of Number of Automorphisms.
    
    
    NA = loadStep(n,p,alg,'NA',nGraphs,0);

    LNA = log(NA);

    ALNA = mean(LNA);
    MLNA = median(LNA);
    VLNA = var(LNA);

end

