function [ A ] = generateHighlySymmetricGraph( n , p )
    
    ssgg = SymmetricSmallGraphGenerator(p);
    scg = SymmetricConnectionGenerator(p);
    
    allSmallGraphs = {};
    nVerticesSoFar = 0;
    while nVerticesSoFar < n
        proposedNewNumberOfVertices = n+1;
        while nVerticesSoFar + proposedNewNumberOfVertices > n
            proposedNewNumberOfVertices = ceil(rand() * 4);
        end
        nVerticesSoFar = nVerticesSoFar + proposedNewNumberOfVertices;
        allSmallGraphs = horzcat(allSmallGraphs, {ssgg.generate(proposedNewNumberOfVertices)});
    end
    
    A = zeros(n, n);
    
    nGraphs = numel(allSmallGraphs);
    x = 0;
    for i = 1 : nGraphs
        d1 = size(cell2mat(allSmallGraphs(i)), 1);
        xRange = x+1 : x+d1;
        A(xRange, xRange) = cell2mat(allSmallGraphs(i));
        y = x + d1;
        for j = i+1 : nGraphs
            d2 = size(cell2mat(allSmallGraphs(j)), 1);
            yRange = y+1 : y+d2;
            
            conns = scg.getBothSymmetricRandomConnections(d1, d2);
            A(xRange, yRange) = conns;
            A(yRange, xRange) = conns';
            y = y + d2;
        end
        x = x + d1;
    end
end

