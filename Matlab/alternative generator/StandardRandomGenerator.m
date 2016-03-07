function [ graphSet ] = StandardRandomGenerator( v, p, nGraphs )
    
    function [ A ] = randGraph(v, p)
        k = 1 - sqrt(1 - p);
        r = rand(v, v);
        t = (r > k) & (ones(v, v) - eye(v, v));
        A = t & t';
    end
    
    A = graph6Encode(randGraph(v, p));
    
    graphSet = char(zeros(nGraphs, size(A, 2)));
    for i = 1 : nGraphs
        graphSet(i,:) = graph6Encode(randGraph(v, p));
    end

end

