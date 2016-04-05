function [ xs, ys ] = getGraphableDistribution2( nGraphs, n )

    a = nGraphs(nGraphs(:,1) == n,:);
    a = sortrows(a);
    G = a(:,3);
    E = a(:,2);
    
    pE = E / max(E);
    plG = log(G) / sum(log(G));

    xs = pE;
    ys = plG;
    
end

