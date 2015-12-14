function visualizeGraphs( graphs_name )
    graphs = evalin('base', graphs_name);
    for i = 1 : size(graphs)
        g = graph(graph6(graphs(i,:)));
        plot(g);
        c = char(64 + i);
        path = strcat('visualization/',graphs_name,'-',c,'.png');
        print(path,'-dpng');
        close all;
    end 
end

