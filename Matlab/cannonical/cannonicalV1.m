function [ B , finalPerm ] = cannonicalV1( A )
    
    function [ cellz ] = sortCells( cellz )
        swapped = 1;
        while swapped
            swapped = 0;
            for index = 1 : size(cellz, 2) - 1
                s1 = size(cell2mat(cellz(index)),2);
                s2 = size(cell2mat(cellz(index+1)),2);
                if (s1 > s2)
                    temp = cellz(index);
                    cellz(index) = cellz(index+1);
                    cellz(index+1) = temp;
                    swapped = 1;
                end
            end
        end
    end

    function [ comparison ] = compareMatrices(m1, m2)
        if (isequal(m1, m2))
            comparison = 0;
        else
            diff = m1 - m2;
            temp = diff(diff ~= 0);
            comparison = sign(temp(1));
        end
    end

    function [ remainingPerms ] = trimPerms ( originalPerms )
        p = originalPerms(1,:);
        bestA = A(p,p);
        bestPs = p;
        for index = 2 : size(originalPerms, 2)
            p = originalPerms(index,:);
            comp = compareMatrices(bestA, A(p,p));
            if (comp == 1)
                bestA = A(p,p);
                bestPs = p;
            elseif (comp == 0)
                bestPs = vertcat(bestPs, p);
            end
        end
        remainingPerms = bestPs;
    end

    function [ resultingPerms ] = combinePermutations ( aPerms, bPerms )
        [nPermsA, vA] = size(aPerms);
        [nPermsB, vB] = size(bPerms);  
        resultingPerms = zeros(nPermsA * nPermsB, vA + vB);
        resultingPerms(:,vA+1:end) = repmat(bPerms, nPermsA, 1);
        for index = 1 : nPermsB
            resultingPerms((((1:nPermsA)-1)*nPermsB)+index,1:vA) = aPerms;
        end
        resultingPerms = trimPerms (resultingPerms);
    end

    qecp = findQuaziEquivalenceClassesPlus(A);
    % Sort qecP by size of the class. (STABLE)
    qecp = sortCells(qecp);
    
    allPerms = cell(size(qecp));
    for i = 1 : size(qecp, 2)
        allPerms(i) = {perms(cell2mat(qecp(i)))};
    end
    
    ps = cell2mat(allPerms(1));
    for i = 2 : size(allPerms, 2)
        ps = combinePermutations(ps, cell2mat(allPerms(i)));
    end
    
    disp(size(ps));
    finalPerm = ps(1,:);
    disp(finalPerm);
    B = A(finalPerm, finalPerm);
    
end

