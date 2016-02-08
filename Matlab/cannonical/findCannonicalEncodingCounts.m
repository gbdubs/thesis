function [ m ] = findCannonicalEncodingCounts( v )
    m = containers.Map('KeyType','char','ValueType','int32');
    
    function incrementCount (encoding)
        if (m.isKey(encoding))
            m(encoding) = m(encoding) + 1;
        else
            m(encoding) = 1;
        end
    end

    max = 2 ^ ( v * (v-1) / 2) - 1;
    threshold = 0;
    delta = .01;
    
    
    for i = 0 : max
        if (i / max > threshold)
            disp (['Completed ',num2str(i),' of ',num2str(max),' graphs.']);
            threshold = threshold + delta;
        end
        
        A = readGraphFromBitstring(v, i);
        [B, perm] = cannonicalV1(A);
        encoded = graph6Encode(B);
        incrementCount(encoded);
    end
end

