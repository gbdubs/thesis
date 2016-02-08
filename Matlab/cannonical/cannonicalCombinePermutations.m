function [ resultingPerms ] = cannonicalCombinePermutations ( aPerms, bPerms )
    [nPermsA, vA] = size(aPerms);
    [nPermsB, vB] = size(bPerms);  
    resultingPerms = zeros(nPermsA * nPermsB, vA + vB);
    resultingPerms(:,vA+1:end) = repmat(bPerms, nPermsA, 1);
    for index = 1 : nPermsB
        resultingPerms((((1:nPermsA)-1)*nPermsB)+index,1:vA) = aPerms;
    end
end