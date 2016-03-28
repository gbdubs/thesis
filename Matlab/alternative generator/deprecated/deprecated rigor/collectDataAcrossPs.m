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
    
    allFilePaths = [];
    
    for i = 1 : numel(allPaths)
        files = dir(cell2mat(allPaths(i)))';
        for file = files
            if ~file.isdir
                filePath = {[cell2mat(allPaths(i)),'/',file.name]};
                allFilePaths = vertcat(allFilePaths, filePath);
            end
        end
    end
    
    pValues = zeros(numel(allFilePaths), 1);
    metricValues = zeros(numel(allFilePaths), 1);
    
    for i = 1 : numel(allFilePaths);
        thePath = cell2mat(allFilePaths(i));
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

