function [ result ] = generateLabeledKs( graph , runUntil )
    s = size(graph);
    result = zeros(s(1), runUntil + 1);
    result(:,1:runUntil) = generateKs(graph, runUntil);
    result(:,runUntil+1) = 1:size(graph);
    result = sortrows(result);
    
end

