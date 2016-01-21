function visualizeAll( graphs_name )
    if (iscell(graphs_name))
        for i = 1 : size(graphs_name, 2)
            visualizeAll(cell2mat(graphs_name(i)));
        end
    else
        graphs = evalin('base', graphs_name);
        for i = 1 : size(graphs)
            A = graph6(graphs(i,:));
            visualizeGraphPaths(A, strcat(graphs_name, '-', char(64+i)), false);
        end
    end
end

