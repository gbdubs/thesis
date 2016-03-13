function [ comparison ] = cannonicalCompareMatrices(m1, m2)
    diff = m1 - m2;
    temp = find(diff,1);
    if numel(temp) == 0
        comparison = 0;
    else
        comparison = sign(diff(temp));
    end
end
