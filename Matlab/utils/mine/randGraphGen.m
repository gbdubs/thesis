function [ output_args ] = randGraphGen(nNodes, nEdges)
    result = zeros(nNodes, nNodes);
    for i = 1 : nEdges
        x = ceil(nNodes * rand);
        y = ceil(nNodes * rand);

        while (x == y || result(x,y) == 1)
            x = ceil(nNodes * rand);
            y = ceil(nNodes * rand);
        end
        result(x,y) = 1;
        result(y,x) = 1;
    end
    output_args = result;
end
