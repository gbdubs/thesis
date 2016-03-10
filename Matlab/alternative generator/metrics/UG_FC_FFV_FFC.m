function [ uniqueGraphs, frequencyCounts, ffValues, ffCounts ] = UG_FC_FFV_FFC( graphSet )
    
    % UG  = The list of Unique Graphs
    % FC  = Frequency of unique graphs
    % FFV = Graph n-collision Bins
    % FFC = Graph n-collision Counts

    [uniqueGraphs, ~, frequencyDist] = unique(graphSet, 'rows');
    
    [frequencyCounts, ~] = hist(frequencyDist, unique(frequencyDist));
    
    [ffCounts, ffValues] = hist(frequencyCounts, unique(frequencyCounts));
    
end

