function [ pValues, metricValues ] = collectDataAcrossPs(n, alg, metric, updateAllPaths)
    if nargin < 4
        updateAllPaths = 1;
    end
    
    if updateAllPaths
        updateAllPathsData();
    end
    
    load('alternative generator/data/allPaths.mat');

    allPaths = applyPathRestriction(allPaths, ['/alg=',alg,'/results/',metric]);
    allPaths = applyPathRestriction(allPaths, ['/n=',num2str(n)]);
    
    pValues = zeros(numel(allPaths), 1);
    metricValues = zeros(numel(allPaths), 1);
    
    for i = 1 : numel(allPaths);
        thePath = cell2mat(allPaths(i));
        theStart = strfind(thePath,'/p=') + 3;
        theEnd = strfind(thePath, '/alg=') - 1;
        p = str2double(thePath(theStart:theEnd));
        pValues(i) = p;
        
        before = who;
        load(thePath);
        after = who;
        varNames = setdiff(after, before);
        varName = cell2mat(varNames(1));
        eval(['result = ',varName,';']);
        
        metricValues(i) = result;
    end
end

