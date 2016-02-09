function [ probabilities ] = generateErdosRenyi( v, e, n )
    n = double(n);
    counts = containers.Map('KeyType','char','ValueType','double');
    
    function incrementCount (s)
        if (counts.isKey(s))
            counts(s) = counts(s) + 1;
        else
            counts(s) = 1;
        end 
    end
    t = cputime;
    for i = 1 : n
        % considerTimeEstimation(t, i, n, 100);
        A = generateErdosRenyiRG(v, e);
        B = cannonicalV2(A);
        encoded = graph6Encode(B);
        incrementCount(encoded);
    end
    
    keys = counts.keys;
    
    probabilities = containers.Map('KeyType','char','ValueType','double');
    
    for s = 1 : size(keys, 2)
        key = cell2mat(keys(s));
        probabilities(key) = counts(key) / n;
    end
    
    save(['random graphs/data/erdos-renyi-',num2str(v),'-',num2str(e),'-',num2str(n)], 'probabilities');
    
end

