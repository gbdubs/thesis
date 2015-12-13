function [ output_args ] = findP( A )
    
    for p = 1 : 100
       if (checkP(A, p) == 0)
           output_args = p;
           return;
       end
    end
    output_args = -1;
end

