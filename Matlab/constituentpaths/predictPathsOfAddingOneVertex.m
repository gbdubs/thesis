function [ result ] = predictPathsOfAddingOneVertex( A, attachedTo )

    paths = generateKs(A, 20);
    vec = paths(attachedTo,:);
    memoization = zeros(15, 10);

    function [ toReturn ] = nWays(target, nLoops)
        if memoization(target+1, nLoops) ~= 0
            toReturn = memoization(target+1, nLoops);
            return;
        end

        if target == 0
            toReturn = 1;
            memoization(target+1, nLoops) = toReturn;
            return;
        end
        
        if nLoops == 1
            if (target == 0)
                toReturn = 1;
            else  
                toReturn = vec(target);
            end
            memoization(target+1, nLoops) = toReturn;
            return;
        end
        
        total = 0;
        for k = 0 : target
            subsection = nWays(k, 1) * nWays(target - k, nLoops - 1);
            total = total + subsection;
        end
        toReturn = total;
        memoization(target+1, nLoops) = toReturn;
    end

    result = zeros(1, 15);

    for i = 1 : 15
        leng = i - 2;
        numLoops = 1;
        allOfEm = 0;
        while (leng >= 0)
            allOfEm = allOfEm + nWays(leng, numLoops);
            leng = leng - 2;
            numLoops = numLoops + 1;
        end
        result(i) = allOfEm;
    end
end

