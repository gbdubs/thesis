function [ NUG, ANR, MNR, SQNR, PDL ] = NUG_ANR_MNR_SQNR_PDL( FC )
    
    % NUG = Percentage of the graph set which is represented once (Unique).
    % ANR = Averange number of Repeats (divided by the graph set size).
    % MNR = Maximimum Number of Repeats in the graphset (not divided by GSS).
    % SQNR = Sum(Squared Number of Repeats *NGraphs with those repeats)/nGraphs
    % PDL = Poisson Distribution Lambda for Frequency Counts.

    
    [FFC, FFV] = hist(FC, unique(FC));
    
    NUG = FFC(1) / nGraphs;
    ANR = sum((FFV-1) .* FFC) / nGraphs;
    MNR = max(FFV);
    SQNR = sum((FFV .* FFV) .* FFC) / nGraphs;
    
    pd = fitdist(FC', 'Poisson');
    PDL = pd.lambda;

end

