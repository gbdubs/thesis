function [ uniqueGraphs, counts ] = processListOfPossiblyIsomorphicGraphs( graphs )

    [nGraphs, nchars] = size(graphs);
    
    map =  containers.Map('KeyType','char','ValueType','uint8');
    
    nChars = 0;
    
    t = cputime;
    
    for i = 1 : nGraphs
        %considerTimeEstimation(t, i, nGraphs, 10, 'Possible Isomorphism!');
        
        A = graph6(graphs(i,:));
        B = cannonical(A);
        encoded = graph6Encode(B);
        nChars = max(nChars, size(encoded, 2));
        if map.isKey(encoded)
            map(encoded) = map(encoded) + 1;
        else
            map(encoded) = 1;
        end
    end
        
    uniqueGraphs = char(zeros(map.Count, nchars));
    counts = zeros(1, size(map.keys, 2));
    
    i = 1;
    mks = map.keys;
    for k = 1 : numel(map.keys)
        key = cell2mat(mks(k));
        uniqueGraphs(i,:) = key;
        counts(i) = map(key);
        i = i + 1;
    end
end

