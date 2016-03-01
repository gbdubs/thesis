function [ RHSAutomorphismHolds ] = testForRHSAutomorphisms( conns )
    d1 = size(conns, 1);
    d2 = size(conns, 2);
    n = d1 + d2;
    A = zeros(n, n);

    A(1:d1, d1+1:n) = conns;
    A(d1+1:n, 1:d1) = conns';

    qecs = findQuaziEquivalenceClassesPlus(A);
    
    RHSAutomorphismHolds = 0;
    for i = 1 : size(qecs, 2)
        qec = cell2mat(qecs(i));
        if numel(setdiff(1:d1, qec)) == 0
            RHSAutomorphismHolds = 1;
        end
    end
end

