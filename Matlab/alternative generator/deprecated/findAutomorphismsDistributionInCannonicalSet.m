function [ nAutomorphisms, nAutCounts, nAutBins ] = findAutomorphismsDistributionInCannonicalSet( graphSet )
    
    progressbar;
    nGraphs = size(graphSet, 1);
    nAutomorphisms = zeros(nGraphs, 1);
    
    for i = 1 : nGraphs
        progressbar(i / nGraphs);
        nAutomorphisms(i) = findNumberOfAutomorphisms(graph6(graphSet(i,:)));
    end

    [nAutCounts, nAutBins] = hist(nAutomorphisms, unique(nAutomorphisms));

end

