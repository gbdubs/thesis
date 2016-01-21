function [ output_args ] = augmentGraphWithEdges( A, newConnections)
    v = size(A, 2);
    B = A;
    for i = 1 : size(newConnections, 1)
        B(newConnections(i, 1), newConnections(i, 2)) = 1;
        B(newConnections(i, 2), newConnections(i, 1)) = 1;
    end
    output_args = B;
end

