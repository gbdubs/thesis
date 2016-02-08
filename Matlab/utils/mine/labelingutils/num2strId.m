function [ result ] = num2strId( n )
    if n < 26
        result = char(65+n);
        return;
    end
    result = [num2strId(n / 26), num2strId(mod(n, 26))];
end