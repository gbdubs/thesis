% TESTER TO SEE HOW MUCH FASTER DOUBLE PRECISION IS THAN UINT64 w/r/t CANNONIZATION.

dataset = data_6;

t = cputime;
for i = 1 : size(dataset, 1)
    if (mod(i, 10) == 0)
        estimateTimeRemaining(t, i, size(dataset, 1));
    end
    cannonicalV1(graph6(dataset(i,:)));
end
disp(['UINT64 METHOD ', num2str(cputime - t), ' seconds.']);

t = cputime;
for i = 1 : size(dataset, 1)
    if (mod(i, 10) == 0)
        estimateTimeRemaining(t, i, size(dataset, 1));
    end
    cannonicalV2(graph6(dataset(i,:)));
end
disp(['DOUBLE METHOD ', num2str(cputime - t), ' seconds.']);