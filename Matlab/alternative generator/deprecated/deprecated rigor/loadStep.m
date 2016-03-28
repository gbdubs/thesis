function [ result, ns, ps ] = loadStep( n, p, alg, metric, nGraphs, shouldAssign)

    if nargin < 6
        shouldAssign = 1;
    end

    result = [];
    ns = [];
    ps = [];
    
    if numel(n) == 1 && numel(p) == 1
    
        if n ~= -1 && p ~= -1 && numel(alg)>1 && nGraphs ~= -1
            pathName = pathToRandomGraphResultData(n,p,alg,nGraphs,metric);
            if exist(pathName, 'file')
                before = who;
                load(pathName);
                after = who;
                varNames = setdiff(after, before);
                varName = cell2mat(varNames(1));
                eval(['result = ',varName,';']);
                if shouldAssign
                    assignin('base', varName, result);
                end
            else
                disp (['FILE DIDN"T EXIST: [',pathName,']']);
            end
            return;
        end
        
        load('alternative generator/data/allPaths.mat');

        allPaths = applyPathRestriction(allPaths, '/results');

        if alg ~= -1
            allPaths = applyPathRestriction(allPaths, ['alg=',alg]);
        end

        if metric ~= -1
            allPaths = applyPathRestriction(allPaths, ['/', metric]);
        end
    
        if n ~= -1
            allPaths = applyPathRestriction(allPaths, ['n=',num2str(n),'/']);
        end

        if p ~= -1
            allPaths = applyPathRestriction(allPaths, ['p=',num2str(p),'/']);
        end

        for i = 1 : numel(allPaths)
            fileName = [pwd, '/', cell2mat(allPaths(i)), '/', num2str(nGraphs), '.mat'];
            if exist(fileName, 'file')
                before = who;
                load(fileName);
                after = who;
                varNames = setdiff(after, before);
                varName = cell2mat(varNames(1));
                eval(['result = ',varName,';']);
                if shouldAssign
                    assignin('base', varName, result);
                end
            end
        end
    else
        ns = n;
        ps = p;
        
        result = zeros(numel(n), numel(p));
        
        for i = 1 : numel(ns)
            n = ns(i);
            for j = 1 : numel(ps)
                p = ps(j);
                [temp, ~, ~] = loadStep(n,p,alg,metric,nGraphs, 0);
                result(i, j) = temp;
            end
        end
    end
end


