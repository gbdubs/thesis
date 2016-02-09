function [ B , finalPerm ] = cannonicalV2( A )

    qecp = findQuaziEquivalenceClassesPlus(A);
    
    qecp = cannonicalSortCells(qecp);
    
    allPerms = cell(size(qecp));
    for i = 1 : size(qecp, 2)
        allPerms(i) = {perms(cell2mat(qecp(i)))};
    end
    
    ps = cell2mat(allPerms(1));
    ps = cannonicalTrimPerms(A, ps);
    for i = 2 : size(allPerms, 2)
        ps = cannonicalCombinePermutations(ps, cell2mat(allPerms(i)));
        ps = cannonicalTrimPerms(A, ps);
    end
    
    finalPerm = ps(1,:);
    B = A(finalPerm, finalPerm);
    
end

