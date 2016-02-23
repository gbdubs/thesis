function [ C ] = graphUnion( A, B )
    C = zeros(size(A) + size(B));
    nA = size(A, 1);
    nB = size(B, 1);
    C(1:nA, 1:nA) = A;
    C(nA+1:nB, nA+1:nB) = B;
end

