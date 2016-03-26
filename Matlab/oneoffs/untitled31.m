inverses = zeros(size(v10CoPaths));

for i = 1 : size(v10CoPaths, 1)
    inverses(i,:) = graph6Encode(cannonical(invertGraph(graph6(v10CoPaths(i,:)))));
end

nonReppedInverses = setdiff(inverses, v10CoPaths, 'rows');

v10CoPaths = unique([v10CoPaths; nonReppedInverses], 'rows');