function [ A ] = readGraphFromBitstringAdv( v, i )

    s = zeros((v * (v-1))/2, 1);

    t = dec2bin(i) == '1';
    
    s(end-size(t, 2)+1:end) = t;
    
    idx = zeros(v * v, 2);
    idx(:, 1) = repmat(1:v, 1, v) + floor(((1 : v*v) - 1 )/ v) + 1;
    idx(:, 2) = ceil(((1 : v*v))/ v);
    
    idx = idx(idx(:, 1) <= v, :);
    idx = idx(s == 1,:);
    
    A = graphFromConnections(idx);
end