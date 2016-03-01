nDataPoints = 10000;
n = 5;

% Generating the idealized output

idealized = data_5;
output = zeros(nDataPoints, n * (n-1)/2);

indices = 0 : (n * n - 1);
indices = indices(mod(indices, n) > floor(indices / n)) + 1;

for i = 1 : nDataPoints
    idx = ceil(rand(1) * size(idealized, 1));
    A = graph6(idealized(idx, :));
    perm = randperm(n);
    A = A(perm, perm);
    output(i,:) = A(indices);
end


% Generating the random input
input = zeros(nDataPoints, n*(n-1)/2);
for i = 1 : nDataPoints
    A = randGraphGen(n, sum(output(i, :)) / 2);
    input(i, :) = A(indices);
end

