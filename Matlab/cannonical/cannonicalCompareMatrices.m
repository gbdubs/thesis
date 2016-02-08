function [ comparison ] = cannonicalCompareMatrices(m1, m2)
    if (isequal(m1, m2))
        comparison = 0;
    else
        diff = m1 - m2;
        temp = diff(diff ~= 0);
        comparison = sign(temp(1));
    end
end
