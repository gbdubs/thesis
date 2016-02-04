function create1SparseGraphTestSet( v, numberOfGraphs )
    template = graph6Encode(zeros(v, v));
    
    encodedGraphs = char(zeros(numberOfGraphs, size(template, 2)));
    
    disp(['Began creating all of the ',num2str(numberOfGraphs),'graphs... This may take some time... ']);
    tenths = 0;
    for i = 1 : numberOfGraphs
        if (i / numberOfGraphs > tenths)
            tenths = tenths + 0.1;
            disp(['Creating ', num2str(i), '/', num2str(numberOfGraphs)]);
        end
        A = generate1SparseGraph(v);
        encodedGraphs(i,:) = graph6Encode(A);
    end
    
    fileName = ['test graphs/1Sparse/',num2str(v),'#',num2str(numberOfGraphs),'.txt'];
    fid = fopen(fileName,'wt');
    
    for i = 1 : numberOfGraphs-1
        fprintf(fid, [encodedGraphs(i,:), '\n']);
    end
    fprintf(fid, encodedGraphs(numberOfGraphs,:));
    
    fclose(fid);
end