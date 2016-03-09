function [ varName ] = randomGraphDataVariableName( VAR, N, P, ALG, NGRAPHS )
    varName = [VAR, '_', ALG, '_', num2str(N), '_', num2str(P), '_', num2str(NGRAPHS)];
end