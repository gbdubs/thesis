function [ nAutomorphisms, nAutCounts, nAutBins ] = findAutomorphismsDistributionInCannonicalSet( graphSet )
    
    nGraphs = size(graphSet, 1);
    nAutomorphisms = zeros(nGraphs, 1);
    
    for i = 1 : nGraphs
        nAutomorphisms(i) = findNAutomorphisms(graph6(graphSet(i,:)));
    end

    [nAutCounts, nAutBins] = hist(nAutomorphisms, unique(nAutomorphisms));

end

