function [ output_args ] = funky( A , k )
    
    n = size(A, 1); 
    a = zeros(n, n);
    a(k, k) = 1;

    for i = 1 : 10
        b = A * a;
        c = b + repmat((sum(b, 2))/i, 1, n) .* eye(n);
        a = c;
    end
end

