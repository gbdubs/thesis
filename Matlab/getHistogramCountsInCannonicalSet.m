function [ uniqueGraphs, frequencyCounts, ffValues, ffCounts ] = getHistogramCountsInCannonicalSet( v )
    
    [uniqueGraphs, ~, frequencyDist] = unique(v, 'rows');
    
    [frequencyCounts, ~] = hist(frequencyDist, unique(frequencyDist));
    
    [ffCounts, ffValues] = hist(frequencyCounts, unique(frequencyCounts));
    
end

