function create2DenseGraphTestSet( v, numberOfGraphs )
    template = graph6Encode(zeros(v, v));
    
    encodedGraphs = char(zeros(numberOfGraphs, size(template, 2)));
    
    disp(['Began creating all of the ',num2str(numberOfGraphs),' dense graphs with ',num2str(v),' vertices... This may take some time... ']);
    tenths = 0;
    for i = 1 : numberOfGraphs
        if (i / numberOfGraphs > tenths)
            tenths = tenths + 0.1;
            disp(['Creating ', num2str(i), '/', num2str(numberOfGraphs)]);
        end
        A = generate2DenseGraph(v);
        encodedGraphs(i,:) = graph6Encode(A);
    end
    
    fileName = ['test graphs/2Dense/',num2str(v),'#',num2str(numberOfGraphs),'.txt'];
    fid = fopen(fileName,'wt');
    
    for i = 1 : numberOfGraphs-1
        fprintf(fid, '%s\n', encodedGraphs(i,:));
    end
    
    fprintf(fid, '%s', encodedGraphs(numberOfGraphs,:));
    
    fclose(fid);
end