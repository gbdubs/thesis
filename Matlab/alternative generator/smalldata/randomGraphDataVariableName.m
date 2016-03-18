function [ varName ] = randomGraphDataVariableName( METRIC, N, P, ALG, NGRAPHS, RUN)
    P = round(P * 100);
    varName = [METRIC, '_', ALG, '_', num2str(N), '_', num2str(P), '_', num2str(NGRAPHS)];
    if nargin == 6
        varName = [varName, '_', num2str(RUN)];
    end
end