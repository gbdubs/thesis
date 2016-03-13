function [ result ] = convertDataToCannonical( data )
    global cannonicalMemoization
    progressbar;
    result = char(zeros(size(data)));
    s = size(data, 1);
    for i = 1 : s
        if (floor(100*(i+1)/s) > floor(100*i/s))
            progressbar(i/s);
        end
        eA = data(i,:);
        if cannonicalMemoization.isKey(eA)
            eB = cannonicalMemoization(eA);
        else
            A = graph6(eA);
            B = cannonicalV4(A);
            eB = graph6Encode(B);
            cannonicalMemoization(eA) = eB;
        end
        result(i,:) = eB;
    end
end

