function [ ALNA, MLNA, VLNA ] = ALNA_MLNA_VLNA( NA )
    % ALNA = Average of Logarithm of Number of Automorphisms.
    % MLNA = Median of Logarithm of Number of Automorphisms.
    % VLNA = Variance of Logarithm of Number of Automorphisms.
    
    LNA = log(NA);

    ALNA = mean(LNA);
    MLNA = median(LNA);
    VLNA = var(LNA);

end

