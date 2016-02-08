
% Time Comparison, comparing vector operations for creating all matrices of
% a certain size by for loops and vectorization.
v = 9;

max = factorial(v);
t = cputime;
for i = 0 : max-1
    readGraphFromBitstring(v, i);
end
e = cputime - t;
disp(['WAY 1: ', num2str(e)]);

t = cputime;
for i = 0 : max-1
    readGraphFromBitstringAdv(v, i);
end
e = cputime - t;
disp(['WAY 2: ', num2str(e)]);
