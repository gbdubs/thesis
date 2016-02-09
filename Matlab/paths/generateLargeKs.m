function [ largePaths ] = generateLargeKs( A , P )

    function [ M ] = quaziHashMat ( M )
        setRandomFunctionToHash(M);
        map = containers.Map('KeyType','double','ValueType','double');
        allVals = sort(unique(M));
        for i1 = 1 : size(allVals, 1)
            map(allVals(i1)) = quaziHashValue(allVals(i1));
        end
        for i1 = 1 : size(M, 1)
            for i2 = 1 : size(M, 2)
                M(i1, i2) = map(M(i1, i2));
            end
        end
    end

    function setRandomFunctionToHash( M ) 
        diagonal = zeros(size(M, 1), 1);
        for idx = 1 : size(M, 1)
            diagonal(idx) = M(idx, idx);
        end
        diagonal = sort(diagonal);
        diagonal = DataHash(diagonal, struct('Format', 'uint8'));
        rng(diagonal(1) * diagonal(2) * diagonal(end-1) * diagonal(end-2));
    end

    function [ value ] = quaziHashValue ( value )
        divisor = randi([10000, floor(flintmax / 100000)]);
        value = mod(value, divisor);
    end

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
        if any(any(C >= flintmax))
            B = quaziHashMat(B);
            C = B * A;
        end
        B = C;
    end
end

