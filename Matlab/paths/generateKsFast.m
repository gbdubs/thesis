function [ result ] = generateKsFast( graph , runUntil )
    n = length(graph);

    A = zeros(n, n);
    A(:,:) = graph(:, :);

    runningVariable = A;

    result = zeros(n, runUntil);
    for i = 1 : runUntil
        for j = 1 : n
            temp = runningVariable(j, j);
            if temp >= flintmax
                temp = NaN;
            end
            result(j, i) = temp;
        end
        runningVariable = runningVariable * A;
    end
end

