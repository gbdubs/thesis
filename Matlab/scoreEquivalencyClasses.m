function [ output_args ] = scoreEquivalencyClasses( A )
    n = 0;
    ind = 0;
    for i = 1 : size(A, 2)
        n = n + size(cell2mat(A(1,i)),2);
        if (size(cell2mat(A(1,i)),2) == 1)
            ind = ind + 1;
        end
    end
    output_args = round(100 *(n - ind)/n);
end

