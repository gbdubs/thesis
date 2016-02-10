function [ result ] = convertDataToCannonical( data )
    t = cputime;
    result = char(zeros(size(data)));
    for i = 1 : size(data, 1)
        considerTimeEstimation(t, i, size(data, 1), 1000);
        A = graph6(data(i,:));
        B = cannonical(A);
        E = graph6Encode(B);
        result(i,:) = E;
    end
end

