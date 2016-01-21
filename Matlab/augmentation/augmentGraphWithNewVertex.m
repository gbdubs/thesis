function [ output_args ] = augmentGraphWithNewVertex( A, connectTo )
    v = size(A, 1);
    B = zeros(v + 1, v+1);
    B(1:v, 1:v) = A;
    B(v + 1, connectTo) = 1;
    B(connectTo, v + 1) = 1;
    output_args = B;
end

