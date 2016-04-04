function [ xs, ys ] = getGraphableDistribution( nGraphs, n )

    a = nGraphs(nGraphs(:,1) == n,:);
    a = sortrows(a);
    G = a(:,3);
    E = a(:,2);
    
    pE = E / max(E);
    pG = G / sum(G);
    
    lpG = log(pG);
    
    xs = pE;
    ys = lpG;
    
end

