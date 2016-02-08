function [ remainingPerms ] = cannonicalTrimPerms ( A,  originalPerms )
    p = originalPerms(1,:);
    bestA = A(p,p);
    bestPs = p;
    for index = 2 : size(originalPerms, 1)
        p = originalPerms(index,:);
        comp = cannonicalCompareMatrices(bestA, A(p,p));
        if (comp == 1)
            bestA = A(p,p);
            bestPs = p;
        elseif (comp == 0)
            bestPs = vertcat(bestPs, p);
        end
    end
    remainingPerms = bestPs;
end