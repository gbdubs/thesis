function [ A ] = unpackNeuralNetResult( y )

% Sets bounds.
y = max(0, y);
y = min(1, y);
y = round(y);

n = ceil(sqrt(numel(y)*2));
A = zeros(n, n);

indices = 0 : (n * n - 1);
indices = indices(mod(indices, n) > floor(indices / n)) + 1;

A(indices) = y;
A = A';
A(indices) = y;

end

