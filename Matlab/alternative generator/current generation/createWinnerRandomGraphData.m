function [ graphSet ] = createWinnerRandomGraphData( v, p, nGraphs, runNo)
       
    function [ howAutomorphic ] = automorphicMetric ( A ) 
        qec = findQuaziEquivalenceClasses(A);
        howAutomorphic = prod(factorial(cellfun(@(x) numel(x),qec)));
    end

    function [ A ] = randGraph(v, p)
        k = 1 - sqrt(p);
        r = rand(v, v);
        t = (r > k) & (ones(v, v) - eye(v, v));
        A = t & t';
    end
    
    A = graph6Encode(randGraph(v, p));
    
    graphSet = char(zeros(nGraphs, size(A, 2)));
    
    for i = 1 : nGraphs
        A = randGraph(v, p);
        B = randGraph(v, p);
        amA = automorphicMetric(A);
        amB = automorphicMetric(B);
        
        moreAut = A;
        lessAut = B;
        if amB > amA
            moreAut = B;
            lessAut = A;
        end
        
        if rand() < 1 - 1 / (v - 2)
            graphSet(i,:) = graph6Encode(moreAut);
        else
            graphSet(i,:) = graph6Encode(lessAut);
        end
        
    end

    saveRandomGraphDataResult(graphSet, v, p, 'Winner', 'RAW', nGraphs, runNo);
    
end

