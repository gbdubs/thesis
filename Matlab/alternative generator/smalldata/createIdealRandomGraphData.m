function createIdealRandomGraphData( n, p, nGraphs )
    
    graphSet = char(zeros(nGraphs, size(graph6Encode(zeros(v, v)),2)));

    PATH_TO_GRAPHS = '/home/u/fall12/gward/Desktop/graphs';
    if ~exist(PATH_TO_GRAPHS, 'dir')
        PATH_TO_GRAPHS = '/Users/Grady/Desktop/Thesis/data/smallgraphs';
    end
    
    maxE = (v*(v-1))/2;
    
    fileIndices = sort(binornd(maxE, p, nGraphs, 1));
    [fileCounts, fileNumbers] = hist(fileIndices, unique(fileIndices));
    
    idx = 1;
    progressbar;
    for i = 1 : numel(fileNumbers)
        e = fileNumbers(i);
        toGenerate = fileCounts(i);
        f = textread([PATH_TO_GRAPHS, '/', num2str(v), '-', num2str(e),'.txt'], '%s','delimiter', '\n');
        nPossible = size(f, 1);
        for j = 1 : toGenerate
            progressbar(idx / nGraphs);
            k = ceil(nPossible * rand());
            graphSet(idx,:) = f{k};
            idx = idx + 1;
        end
    end
    
    saveRandomGraphDataResult(graphSet, n, p, 'Ideal', 'RAW', nGraphs);

end

