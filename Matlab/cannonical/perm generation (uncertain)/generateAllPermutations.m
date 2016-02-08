function [ output_args ] = generateAllPermutations( qec )

    v = 0;
    for j = 1 : size(qec, 2)
        v = v + size(cell2mat(qec(j)), 2);
    end

    function [ perms ] = generatePermutationsOfGroups(set1, set2, original)
        s = size(set1, 2);
        if (s == 1)
            original(set1(1)) = set2(1);
            perms = original;
            return;
        end
        perms = [];
        for i = 1 : s
            modset1 = set1(2:s);
            modset2 = set2(set2 ~= set2(i));
            original(set1(1)) = set2(i);
            newPerms = generatePermutationsOfGroups(modset1, modset2, original);
            perms = horzcat(perms, newPerms);
        end
    end

    partialPerms = cell(1, size(qec, 2));
    start = 1;
    
    for qecCounter = 1 : size(qec, 2)
        mat = cell2mat(qec(qecCounter));
        perms = generatePermutationsOfGroups(mat, start : start + size(mat, 2) - 1, zeros(v, 1));
        start = start + size(mat, 2);
        partialPerms(qecCounter) = {perms};
    end
    
    toDivideBy = zeros(1, size(qec, 2));
    toModuloBy = zeros(1, size(qec, 2));
    toDivideBy(1) = 1;
    nPerms = 1;
    
    for j = 1 : size(qec, 2)
        nInPermGroup = size(cell2mat(partialPerms(j)), 2);
        toModuloBy(j) = nInPermGroup;
        if (j ~= size(qec, 2))
            toDivideBy(j+1) = toDivideBy(j) * nInPermGroup;
        end
        nPerms = nPerms * nInPermGroup;
    end
  
    fullPerms = zeros(v, nPerms);
    for j = 1 : nPerms
        k = j - 1;
        indices = zeros(1, size(qec, 2));
        for l = 1 : size(qec, 2)
            indices(l) = mod(floor(k / toDivideBy(l)), toModuloBy(l)) + 1;
            part = cell2mat(partialPerms(l));
            fullPerms(:, j) = fullPerms(:, j) + part(:,indices(l));
        end
    end
        
    output_args = fullPerms;
end

