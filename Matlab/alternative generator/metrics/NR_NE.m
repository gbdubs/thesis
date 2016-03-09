function [ nRegular, nEdges ] = NR_NE( graphSet )
    
    function [ isRegular ] = regular ( A ) 
        temp = sum(A);
        temp = temp - mean(temp);
        isRegular = 1 - any(temp);
    end
    
    nEdges = 0;
    nRegular = 0;
    nGraphs = size(graphSet, 1);
    for i = 1 : nGraphs
        A = graph6(graphSet(i,:));
        nEdges = nEdges + sum(sum(A)) / 2;
        nRegular = nRegular + regular(A);
    end
    nEdges = nEdges / nGraphs;
end

