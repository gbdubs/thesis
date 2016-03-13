function [ largePaths ] = generateLargeKs( A , P )

    n = size(A, 1);
    
    largePaths = zeros(n, P);
    
    B = zeros(n, n);
    
    B = B + A;
    B = B * A;
    
    for p = 1 : P
        largePaths(:,p) = diag(B);
        C = B * A;
        B = C - floor(C / 2^32) * 2^32;
    end
end

