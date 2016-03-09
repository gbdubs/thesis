function [ result ] = convertDataToCannonical( data )
    progressbar;
    result = char(zeros(size(data)));
    s = size(data, 1);
    for i = 1 : s
        progressbar(i/s);
        A = graph6(data(i,:));
        B = cannonical(A);
        E = graph6Encode(B);
        result(i,:) = E;
    end
end

