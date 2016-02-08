function [ output_args ] = findExcessPathsFast( A , k) 
    original = generateKsFast(A, size(A,1)+1);
    augA = augmentGraphWithNewVertex(A, k);
    modified = generateKsFast(augA, size(augA, 1));
    diff = double(modified(1:size(A,1), :)) - double(original);
    output_args = sortrows(diff);
end