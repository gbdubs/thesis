function [ result ] = generatePermMatrixFromVector( vec )

    v = size(vec, 1);
    result = zeros(v, v);
    for i = 1 : v
        result(i, vec(i)) = 1;
    end
    
end