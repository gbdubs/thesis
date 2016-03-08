function [ nAuts ] = findNAutomorphisms( A )

    function [ allPerms ] = generatePermsFromQECs(qecs)
        
        function [ resultingPerms ] = combinePerms ( aPerms, bPerms )
            [nPermsA, vA] = size(aPerms);
            [nPermsB, vB] = size(bPerms);  
            resultingPerms = zeros(nPermsA * nPermsB, vA + vB);
            resultingPerms(:,vA+1:end) = repmat(bPerms, nPermsA, 1);
            for index = 1 : nPermsB
                resultingPerms((((1:nPermsA)-1)*nPermsB)+index,1:vA) = aPerms;
            end
        end
        
        allPerms = perms(cell2mat(qecs(1)));
        
        for i = 2 : numel(qecs)
            allPerms = combinePerms(allPerms, perms(cell2mat(qecs(i))));
        end
        
    end

    qecs = findQuaziEquivalenceClasses(A);
    
    allPerms = generatePermsFromQECs(qecs);
    
    nAuts = 0;
    
    progressbar;
    s = size(allPerms, 1);
    for k = 1 : s
        progressbar(k / s);
        perm = allPerms(k,:);
        equal = 1 - any(any(A - A(perm, perm)));
        nAuts = nAuts + equal;
    end
    
end