function [ output_args ] = graph6Encode( A )

    v = size(A, 1);
    e = (v * (v-1))/2;
    nChars = ceil((e - 1) / 6) + 1;

    i = 1;
    j = 1;

    chars = char(zeros(1, nChars));
    
    chars(1) = char(63 + v);

    charNum = 1;

    while (i <= v && j <= v && charNum <= nChars && ~(i == v && j == v))
        running = 0;
        for bitCount = 1 : 6
            if (i == j)
                j = 1;
                i = i + 1;
            end
            running = running * 2;
            if (i <= v && j <= v)
                running = running + A(i,j);
            end
            j = j + 1;
        end
        c = char(running + 63);
        charNum = charNum + 1;
        chars(charNum) = c;
    end

    output_args = chars;
    return;
    
end

