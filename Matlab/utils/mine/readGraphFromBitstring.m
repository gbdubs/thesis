function [ A ] = readGraphFromBitstring( v, i )
    A = zeros(v, v);
    x = 2;
    y = 1;
    s = dec2bin(i);
    for i = size(s, 2) : -1 : 1
        b = s(i) == '1';
        A(x, y) = b;
        A(y, x) = b;
        y = y + 1;
        if (x == y)
            x = x+1;
            y = 1;
        end
    end
end

