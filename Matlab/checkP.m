

function [ output_args ] = checkP( A , p)
    v = size(A,1);
    n = size(A,3);
    
    result = zeros(v, p, n);
    
    for i = 1 : n
        result(:,:,i) = sortrows(generateKs(A(:,:,i), p));
        for j = 1 : (i-1)
            if (sum(sum((result(:,:,j) - result(:,:,i)).^2)) == 0)
                output_args = 1;
                return;
            end
        end
    end
    output_args = 0;
end

