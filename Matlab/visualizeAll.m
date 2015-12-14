function visualizeAll( graphs_name )
 graphs = evalin('base', graphs_name);
    for i = 1 : size(graphs)
        A = graph6(graphs(i,:));
        visualizeGraphPaths(A, strcat(graphs_name, '-', char(64+i)));
    end 
end

