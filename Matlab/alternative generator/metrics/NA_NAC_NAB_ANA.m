function [ nAutomorphisms, nAutCounts, nAutBins, avgNAut ] = NA_NAC_NAB_ANA( graphSet )

    % NA   = Number of Automorphisms (as a dataset)
    % NAC  = Number of Automorphisms (counts for bins)
    % NAB  = Number of Automorphisms (bins)
    % ANA  = Average Number of Automorphisms

    progressbar;
    nGraphs = size(graphSet, 1);
    nAutomorphisms = zeros(nGraphs, 1);
    
    global nAutomorphismMemoization;
    
    for i = 1 : nGraphs
        progressbar(i / nGraphs);
        EA = graphSet(i,:);
        if nAutomorphismMemoization.isKey(EA)
            nAutomorphisms(i) = nAutomorphismMemoization(EA);
        else
            A = graph6(EA);
            nAutomorphisms(i) = findNumberOfAutomorphisms(A);
            nAutomorphismMemoization(EA) = nAutomorphisms(i);
        end
    end

    [nAutCounts, nAutBins] = hist(nAutomorphisms, unique(nAutomorphisms));

    avgNAut = dot(nAutCounts, nAutBins) / nGraphs;
end

