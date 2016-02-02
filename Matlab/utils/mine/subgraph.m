function [ output_args ] = subgraph( G , less)
% Input  : Adjacency Matrix, and a list of vertices to remove from it
% Output : Smaller graph (subgraph)

    v = size(G, 1);
    idxs = setdiff(1:v, less);
    output_args = G(idxs, idxs);
end

