function [result] = compareProbabilityDistribution( D1, D2 )
    for k = D1.keys
        k = cell2mat(k);
        if ~D2.isKey(k)
            D2(k) = 0;
        end
    end
    for k = D2.keys
        k = cell2mat(k);
        if ~D1.isKey(k)
            D1(k) = 0;
        end
    end
    
    result = zeros(size(D1.keys, 2), 3);
    i = 1;
    for k = D1.keys
        k = cell2mat(k);
        d1rounded = round(D1(k) * 10000) / 100;
        d2rounded = round(D2(k) * 10000) / 100;
        diff = D1(k) - D2(k);
        diffRounded = round(diff* 10000) / 100;
        result(i,:) = [diffRounded, d1rounded, d2rounded];
        i = i + 1;
    end
    result = sortrows(result);
end

