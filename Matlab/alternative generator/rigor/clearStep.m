function clearStep( n, p, alg, step, metric )

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
    
    if step ~= -1
        allPaths = applyPathRestriction(allPaths, ['/', step]);
    end
    
    if metric ~= -1
        allPaths = applyPathRestriction(allPaths, ['/', metric]);
    end
    
    if numel(allPaths) > 5
        progressbar;
    end
    
    for i = 1 : numel(allPaths)
        progressbar(i / numel(allPaths));
        dirName = cell2mat(allPaths(i));
        if exist(dirName, 'dir')
            rmdir(dirName, 's');
        end
    end
end

