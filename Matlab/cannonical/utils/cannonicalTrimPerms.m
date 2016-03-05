function [ remainingPerms ] = cannonicalTrimPerms ( A,  originalPerms , timeout)
    if nargin < 3
        timeout = 10;
    end
    t = cputime;
    p = originalPerms(1,:);
    bestA = A(p,p);
    bestPs = p;
    for index = 2 : size(originalPerms, 1)
        if mod(index, 100) == 0
            if cputime - t > timeout
                error('Cannonical Timeout.');
            end
        end
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