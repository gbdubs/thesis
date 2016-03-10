function [ nAutomorphisms, nAutCounts, nAutBins, avgNAut ] = NA_NAC_NAB_ANA( graphSet )

    % NA   = Number of Automorphisms (as a dataset)
    % NAC  = Number of Automorphisms (counts for bins)
    % NAB  = Number of Automorphisms (bins)
    % ANA  = Average Number of Automorphisms

    progressbar;
    nGraphs = size(graphSet, 1);
    nAutomorphisms = zeros(nGraphs, 1);
    
    for i = 1 : nGraphs
        progressbar(i / nGraphs);
        nAutomorphisms(i) = findNumberOfAutomorphisms(graph6(graphSet(i,:)));
    end

    [nAutCounts, nAutBins] = hist(nAutomorphisms, unique(nAutomorphisms));

    avgNAut = dot(nAutCounts, nAutBins) / nGraphs;
end

