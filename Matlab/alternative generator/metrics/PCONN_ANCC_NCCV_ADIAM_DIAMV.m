function [ PCONN, ANCC, NCCV, ADIAM, DIAMV ] = PCONN_ANCC_NCCV_ADIAM_DIAMV( graphSet )
    % PCONN = Probability of fully connected graph
    % ANCC  = Average Number of connected components
    % NCCV  = Number of connected components Variance
    % ADIAM = Average Graph Diameter
    % DIAMV = Graph Diameter Variance

    nGraphs = size(graphSet,1);
    data = zeros(nGraphs, 2);
    
    for i = 1 : nGraphs
        A = graph6(graphSet(i,:));
        data(i,:) = [diameter(A), numConnectedComponents(A)];
    end
    
    PCONN = sum(data(:,2) == 1)/nGraphs;
    ANCC = mean(data(:,2));
    NCCV = var(data(:,2));
    
    wValidDiam = data(data(:,2) == 1, 1);
    ADIAM = mean(wValidDiam);
    DIAMV = var(wValidDiam);
    
end

