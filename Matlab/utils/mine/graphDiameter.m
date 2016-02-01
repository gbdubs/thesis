function [ output_args ] = graphDiameter( A )
    B = graphallshortestpaths(sparse(A));
    B(isinf(B)) = 0; 
    output_args = max(max(B));  
end