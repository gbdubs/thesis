function [ pairs ] = generatePairsFromClasses( automorphismClasses )
    
    function [ nPairs ] = calculateNPairs ( classes )
        nPairs = 0;
        for c = 1 : size(classes, 2)
            s = size(cell2mat(classes(c)), 2);
            nPairs = nPairs + (s * (s-1)) / 2;
        end
    end
    
    function [ classPairs ] = calculatePairs ( mat )
        s = size(mat, 2);
        classPairs = zeros(s * (s-1)/2, 2);
        index = 1;
        for i = 1 : s
            for j = 1 : s
                if (mat(i) < mat(j))
                    classPairs(index,:) = [mat(i), mat(j)];
                    index = index + 1;
                end
            end
        end
    end

    pairs = zeros(calculateNPairs(automorphismClasses), 2);
    idx = 1;
    for k = 1 : size(automorphismClasses, 2)
        partial = calculatePairs(cell2mat(automorphismClasses(k)));
        pairs(idx: (idx+size(partial, 1)-1),:) = partial;
        idx = idx + size(partial, 1);
    end
end

