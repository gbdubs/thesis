function makeDirectoriesToRandomGraphData(n, p, alg, metric, nGraphs)
    metricFolder = [pwd,'/alternative generator/smalldata/',metric];
    if ~exist(metricFolder,'dir')
        mkdir(metricFolder);
    end
    pathToData = pathToRandomGraphData(n,p,alg,metric,nGraphs);
    if ~exist(pathToData,'file')
        save(pathToData,'metric','alg','n');
    end
end

