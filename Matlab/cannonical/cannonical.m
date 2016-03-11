function [ B ] = cannonical( A )

    global cannonicalMemoization

    eA = graph6Encode(A);
    
    if cannonicalMemoization.isKey(eA)
        B = graph6(cannonicalMemoization(eA));
        return;
    end
    
    B = cannonicalV4(A);
    cannonicalMemoization(eA) = graph6Encode(B);

end

