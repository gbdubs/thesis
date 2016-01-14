function [ output_args ] = findAnAutomorphisms( G )
% Very much a WIP. Not a final product.


n = size(G, 1);

qec = findQuaziEquivalenceClasses(G);

mapping = zeros(2, size(G, 1));
mappedTo = 1;

for i = 1 : size(qec,2)
    mat = cell2mat(qec(i));
    if (size(mat, 2) == 1)
        mapping(:, mappedTo) = [mat(1), mat(1)];
        mappedTo = mappedTo + 1;
    end
end

if (mappedTo <= n)
    
    
end


output_args = mapping;

end

