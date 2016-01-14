function [ output_args ] = invertGraph( graph )
    n = length(graph);
    for i = 1 : n
        for j = i + 1 : n
            original = graph(i,j);
            new = 1;
            if (original == 1);
                new = 0;
            end
            graph(i,j) = new;
            graph(j,i) = new;
        end
    end
    output_args = graph;
end

