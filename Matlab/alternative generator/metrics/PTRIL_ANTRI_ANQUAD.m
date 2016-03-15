function [ PTRIL, ANTRI, ANQUAD ] = PTRIL_ANTRI_ANQUAD( graphSet )
% PTRIL = Percent of graph set that is Triangleless
% ANTRI = Average number of Triangles in each Graph
% ANQUAD = Average number of Quadrilaterals in each Graph

nGraphs = size(graphSet, 1);
N = size(graph6(graphSet(1,:)),1);

nTriangleless = 0;
nTrianglesInAllGraphs = 0;
nQuadrilateralsInAllGraphs = 0;

for i = 1 : nGraphs
    
    A = graph6(graphSet(i,:));
    
    C = generateLargeKs(A, N);
    
    v3 = C(:, 2);
    if numel(find(v3, 1)) == 0
        nTriangleless = nTriangleless + 1;
    end
    
    nTrianglesInAllGraphs = nTrianglesInAllGraphs + sum(v3);
    
    v2 = C(:, 1);
    v4 = C(:, 3);
    excess = sum(v4) - dot(v2, v2);
    nQuadrilateralsInAllGraphs = nQuadrilateralsInAllGraphs + excess;
    
    
end

PTRIL = nTriangleless / nGraphs;
ANTRI = nTrianglesInAllGraphs / nGraphs;
ANQUAD = nQuadrilateralsInAllGraphs / nGraphs;

end

