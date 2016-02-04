function [ A ] = generate2DenseGraph( n )
    % Generates graphs according to the 2Dense Graph Generation Technique
    % proposed by the authors of the 2013 Paper "Solving Graph Isomorphism
    % Using Parameterized Matching", by Mendivelso, Kim, Elnikety, He, Hwang,
    % and Pinzon.
    
    A = invertGraph(generate1SparseGraph(n));
    
end

