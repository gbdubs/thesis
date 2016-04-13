function createMinusOneARandomGraphData( v, p , nGraphs, runNo)

    function [ A ] = gilbertRandGraph(v, p)
        k = 1 - sqrt(p);
        r = rand(v, v);
        t = (r > k) & (ones(v, v) - eye(v, v));
        A = t & t';
    end

    function [ howAutomorphic ] = automorphicMetric ( A ) 
        qec = findQuaziEquivalenceClasses(A);
        howAutomorphic = prod(factorial(cellfun(@(x) numel(x),qec)));
        howAutomorphic = log(howAutomorphic) + 1;
    end

    function [ G ] = generateMinusOne(v, p)
        A = gilbertRandGraph(v+1, p);
        deck = zeros(v+1, v, v);
        score = zeros(v+1,1);
        
        for less = 1 : v+1
            B = subgraph(A,less);
            deck(less,:,:) = B;
            score(less) = automorphicMetric(B);
        end
        
        score = score / sum(score);
        
        remaining = rand();
        
        doneHere = 0;
        for i = 1 : v+1
            if remaining < score(i) && ~doneHere
                G = reshape(deck(i,:,:), v, v);
                doneHere = 1;
            else
                remaining = remaining - score(i);    
            end
        end
    end

    
    graphSet = char(zeros(nGraphs, size(graph6Encode(zeros(v, v)),2)));

    for j = 1 : nGraphs
        graphSet(j,:) = graph6Encode(generateMinusOne(v,p));
    end
    
    saveRandomGraphDataResult(graphSet, v, p, 'MinusOneA', 'RAW', nGraphs, runNo);

end

