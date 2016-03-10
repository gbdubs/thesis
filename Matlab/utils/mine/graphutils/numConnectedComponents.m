function [ ncc ] = numConnectedComponents( A )
    
    function [ reachable ] = getReachableSet (i)
        oldReachable = [];
        reachable = [i];
        while numel(reachable) > numel(oldReachable)
            newReachable = reachable;
            for i = numel(oldReachable)+1 : numel(reachable)
                adjacent = find(A(reachable(i),:));
                newReachable = [newReachable, setdiff(adjacent, newReachable)];
            end
            oldReachable = reachable;
            reachable = newReachable;
        end
    end

    unaccountedVertices = 1 : size(A, 1); 
    ncc = 0;
    
    while numel(unaccountedVertices) > 0
        vertex = unaccountedVertices(1);
        reachable = getReachableSet(vertex);
        unaccountedVertices = setdiff(unaccountedVertices, reachable);
        ncc = ncc + 1;
    end
    
end

