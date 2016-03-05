function [ B , finalPerm ] = cannonicalV4( A )
    try
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
            ps = cannonicalTrimPerms(A, ps, 1000);
        end

        finalPerm = ps(1,:);
        B = A(finalPerm, finalPerm);
    catch
        B = -1;
        finalPerm = -1;
    end
end