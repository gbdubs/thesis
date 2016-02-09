function [ largePaths ] = generateLargeKs( A , P )

    n = size(A, 1);
    
    largePaths = zeros(n, P);
    
    B = zeros(n, n);
    
    B = B + A;
    B = B * A;
    t = cputime;
    for p = 1 : P
        % considerTimeEstimation(t, p, P, 100);
        for i = 1 : n
            largePaths(i, p) = B(i,i);
        end
        C = B * A;
        B = C - floor(C / 2^32) * 2^32;
    end
end

