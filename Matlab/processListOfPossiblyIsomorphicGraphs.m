function [ uniqueGraphs, counts ] = processListOfPossiblyIsomorphicGraphs( graphs )

    [~, n, nGraphs] = size(graphs);
    
    map =  containers.Map('KeyType','char','ValueType','uint8');
    
    nChars = 0;
    
    t = cputime;
    
    for i = 1 : nGraphs
        considerTimeEstimation(t, i, nGraphs, 10);
        
        A = graphs(:,:,i);
        B = cannonical(A);
        encoded = graph6Encode(B);
        nChars = max(nChars, size(encoded, 2));
        if map.isKey(encoded)
            map(encoded) = map(encoded) + 1;
        else
            map(encoded) = 1;
        end
    end
        
    uniqueGraphs = char(zeros(n, n, size(map.keys, 2)));
    counts = zeros(1, size(map.keys, 2));
    
    i = 1;
    for k = 1 : numel(map.keys)
        mks = map.keys;
        key = cell2mat(mks(k));
        uniqueGraphs(:,:,i) = graph6(key);
        counts(i) = map(key);
        i = i + 1;
    end
end

