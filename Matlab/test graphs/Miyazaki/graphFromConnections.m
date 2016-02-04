function [ A ] = graphFromConnections( connections )
    v = max(max(connections));
    A = zeros(v, v);
    A(sub2ind(size(A), connections(:, 1), connections(:, 2))) = 1;
    A(sub2ind(size(A), connections(:, 2), connections(:, 1))) = 1;
end