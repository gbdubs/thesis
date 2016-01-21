function [ regular ] = findRegularGraphs( data )
    n = size(data, 1);
    regularidx = zeros(n,1);
    idx = 1;
    for i = 1 : n
        if range(sum(graph6(data(i,:)))) == 0
            regularidx(idx) = i;
            idx = idx + 1;
        end
    end
    
    regular = data(regularidx(1:idx-1),:);
end

