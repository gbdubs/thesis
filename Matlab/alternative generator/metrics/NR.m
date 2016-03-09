function [ nRegular ] = NR( graphSet )
    
    function [ isRegular ] = regular ( A ) 
        temp = sum(A);
        temp = temp - mean(temp);
        isRegular = 1 - any(temp);
    end
    
    nRegular = 0;
    nGraphs = size(graphSet, 1);
    for i = 1 : nGraphs
        nRegular = nRegular + regular(graph6(graphSet(i,:)));
    end
end

