function [ A ] = generateErdosRenyiRG( V, E )
    A = zeros(V, V);
    edges = randperm(V * (V-1) / 2) <= E;
    x = 2;
    y = 1;
    for i = 1 : size(edges)
        b = edges(i);
        A(x, y) = b;
        A(y, x) = b;
        y = y + 1;
        if (x == y)
            x = x+1;
            y = 1;
        end
    end
end

