function [ varName ] = randomGraphDataVariableName( VAR, N, P, ALG, NGRAPHS )
    P = round(P * 100);
    varName = [VAR, '_', ALG, '_', num2str(N), '_', num2str(P), '_', num2str(NGRAPHS)];
end