function [ output_args ] = subgraph( G , less)
    v = size(G, 1);
    idxs = setdiff(1:v, less);
    output_args = G(idxs, idxs);
end

