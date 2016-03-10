function [ graphSet ] = StandardRandomGenerator( v, p, nGraphs , shouldSave)
    
    if nargin < 4
        shouldSave = 1;
    end

    if shouldSave
        thePath = pathToRandomGraphData(v, p, 'Standard', nGraphs, 0);
        if exist(thePath, 'file')
            load(thePath);
            return
        end
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
        graphSet(i,:) = graph6Encode(randGraph(v, p));
    end

    if shouldSave
        thePath = pathToRandomGraphData(v, p,'Standard', nGraphs, 0);
        save(thePath, 'graphSet');
    end
end

