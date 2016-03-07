function [ uniqueGraphs, frequencyCounts, ffValues, ffCounts ] = getHistogramCountsInCannonicalSet( graphSet )
    
    [uniqueGraphs, ~, frequencyDist] = unique(graphSet, 'rows');
    
    [frequencyCounts, ~] = hist(frequencyDist, unique(frequencyDist));
    
    [ffCounts, ffValues] = hist(frequencyCounts, unique(frequencyCounts));
    
end

