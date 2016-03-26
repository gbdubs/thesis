function [ NUG, ANR, MNR, SQNR, PDL ] = NUG_ANR_MNR_SQNR_PDL( n, p, alg, nGraphs )
% NUG = Percentage of the graph set which is represented once (Unique).
% ANR = Averange number of Repeats (divided by the graph set size).
% MNR = Maximimum Number of Repeats in the graphset (not divided by GSS).
% SQNR = Sum(Squared Number of Repeats *NGraphs with those repeats)/nGraphs
% PDL = Poisson Distribution Lambda for Frequency Counts.

    FC = loadStep(n,p,alg,'FC',nGraphs,0);
    if numel(FC) == 0
        calculateMetric('FC',n,p,alg,nGraphs);
    end
    FC = loadStep(n,p,alg,'FC',nGraphs,0);
    FFV = loadStep(n,p,alg,'FFV',nGraphs,0);
    FFC = loadStep(n,p,alg,'FFC',nGraphs,0);
    
    NUG = FFC(1) / nGraphs;
    ANR = sum((FFV-1) .* FFC) / nGraphs;
    MNR = max(FFV);
    SQNR = sum((FFV .* FFV) .* FFC) / nGraphs;
    
    pd = fitdist(FC', 'Poisson');
    PDL = pd.lambda;

end

