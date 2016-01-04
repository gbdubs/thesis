function generateAllComparisons( graphs_name )
    if (iscell(graphs_name))
        for i = 1 : size(graphs_name, 2)
            generateAllComparisons(cell2mat(graphs_name(i)));
        end
    else
        graphs = evalin('base', graphs_name);
        for i = 1 : 2 : size(graphs)
            A = graph6(graphs(i,:));
            B = graph6(graphs(i+1,:));
            str = generateComparisonString(A, B);
            filename = strcat('visualization/comps/',graphs_name, '-', char(64+i),char(65+i),'.txt');
            fileID = fopen(filename, 'w');
            fprintf(fileID, str);
        end
    end
end

