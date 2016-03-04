function [ copathsGraphIndices ] = findCoPaths( graphs )
    
    
    n = size(graph6(graphs(1,:)),1);
    nGraphs = size(graphs, 1);

    
    allPaths = zeros(n, n, nGraphs);
    graphIndexes = 1 : nGraphs;
    
    for i = 1 : nGraphs
        allPaths(:,:,i) = sortrows(generateLargeKs(graph6(graphs(i,:)), n));
    end
    
    function [result] = compare(i, j)
        m1 = allPaths(:,:,i);
        m2 = allPaths(:,:,j);
        idx = find(m1 ~= m2);
        if (numel(idx) < 1)
            result = 0;
        else
            result = (m1(idx(1)) < m2(idx(1))) * 2 - 1;
        end
      
    end
    
    function swap(i, j)
        temp = allPaths(:,:,i);
        allPaths(:,:,i) = allPaths(:,:,j);
        allPaths(:,:,j) = temp;
        temp = graphIndexes(i);
        graphIndexes(i) = graphIndexes(j);
        graphIndexes(j) = temp;
    end
    
    madeSwap = 1;
    while madeSwap
        madeSwap = 0;
        for i = 1 : nGraphs-1
            if compare(i, i+1) == -1
                swap(i, i+1);
                madeSwap = 1;
            end
        end
    end
    
    copathsGraphIndices = {};
    running = [graphIndexes(1)];
    for i = 2 : nGraphs
        if compare(i-1, i) == 0
            running = horzcat(running, graphIndexes(i));
        else
            if numel(running) > 1
                copathsGraphIndices = horzcat(copathsGraphIndices, {running});
            end
            running = graphIndexes(i);
        end
    end
    if numel(running) > 1
        copathsGraphIndices = horzcat(copathsGraphIndices, {running});
    end
    
end

