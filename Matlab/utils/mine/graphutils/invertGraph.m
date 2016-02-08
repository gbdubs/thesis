function [ inverted ] = invertGraph( A )
% Input  : Adjacency Matrix of Graph
% Output : Adjacency Matrix of Inverted Graph.

    v = size(A, 1);
    inverted = ~A;
    inverted((0:(v-1)) * (v+1) + 1) = 0;
end