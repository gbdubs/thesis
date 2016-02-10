function [ bestPerms ] = cannonicalGenerateAllMaximalPerms( A , idx)
    subgraph = A(idx, idx);
    s = sum(sum(subgraph));
    if s == 0 || s == numel(subgraph) - size(subgraph, 1)
        bestPerms = perms(idx);
    else
        allPerms = perms(idx);
        bestPerms = allPerms(1);
        bestSubgraph = A(bestPerms, bestPerms);
        for i = 2 : size(allPerms, 1)
            p = allPerms(i,:);
            B = A(p, p);
            comparison = cannonicalCompareMatrices(B, bestSubgraph);
            if comparison == 1
                bestPerms = p;
                bestSubgraph = B;
            elseif comparison == 0
                bestPerms = vertcat(bestPerms, p);
            end
        end     
    end
end

