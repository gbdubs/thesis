function [ pathToTheData ] = pathToRandomGraphData( n, p, alg, metric, nGraphs )

    pathToTheData = [pwd,'/alternative generator/smalldata/',metric,'/',alg,'_',num2str(n),'.mat'];

end

