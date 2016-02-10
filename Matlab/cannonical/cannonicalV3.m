function [ B , finalPerm ] = cannonicalV3( A )

    qecp = findQuaziEquivalenceClassesPlus(A);
    
    qecp = cannonicalSortQECs(A, qecp);
    
    allPerms = cell(size(qecp));
    for i = 1 : size(qecp, 2)
        idx = cell2mat(qecp(i));
        allPerms(i) = {cannonicalGenerateAllMaximalPerms(A, idx)};
    end
    
    ps = cell2mat(allPerms(1));
    ps = cannonicalTrimPerms(A, ps);
    for i = 2 : size(allPerms, 2)
        ps = cannonicalCombinePermutations(ps, cell2mat(allPerms(i)));
        % disp(['S: ',num2str(i), ' / ', num2str(size(allPerms,2)), ' : NPERMS = ',num2str(size(ps, 1))]);
        ps = cannonicalTrimPerms(A, ps);
        % disp(['E: ',num2str(i), ' / ', num2str(size(allPerms,2)), ' : NPERMS = ',num2str(size(ps, 1))]);
    end
    
    finalPerm = ps(1,:);
    B = A(finalPerm, finalPerm);
    
end