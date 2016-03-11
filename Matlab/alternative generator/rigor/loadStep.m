function [ temp ] = loadStep( n, p, alg, metric, nGraphs)

    temp = [];
    load('alternative generator/data/allPaths.mat');

    if n ~= -1
        allPaths = applyPathRestriction(allPaths, ['n=',num2str(n)]);
    end
    
    if p ~= -1
        allPaths = applyPathRestriction(allPaths, ['p=',num2str(p)]);
    end
    
    if alg ~= -1
        allPaths = applyPathRestriction(allPaths, ['alg=',alg]);
    end
    
    
    allPaths = applyPathRestriction(allPaths, '/results');
    
    
    if metric ~= -1
        allPaths = applyPathRestriction(allPaths, ['/', metric]);
    end
    
    if numel(allPaths) > 5
        progressbar;
    end
    
    for i = 1 : numel(allPaths)
        if numel(allPaths) > 5
            progressbar(i / numel(allPaths));
        end
        fileName = [pwd, '/', cell2mat(allPaths(i)), '/', num2str(nGraphs), '.mat'];
        if exist(fileName, 'file')
            before = who;
            load(fileName);
            after = who;
            varNames = setdiff(after, before);
            varName = cell2mat(varNames(1));
            eval(['temp = ',varName,';']);
            assignin('base', varName, temp);
        end
    end
end


