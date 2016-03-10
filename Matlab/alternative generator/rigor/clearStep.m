function clearStep( n, p, alg, step, metric )

    function [ o ] = applyRestriction ( i, rest )
        t = strfind( i, rest );
        r = cellfun(@isempty,t);
        o = i(~r);
    end

    allPaths = strsplit(genpath('alternative generator/data'),':')';

    if n ~= -1
        allPaths = applyRestriction(allPaths, ['n=',num2str(n)]);
    end
    
    if p ~= -1
        allPaths = applyRestriction(allPaths, ['p=',num2str(p)]);
    end
    
    if alg ~= -1
        allPaths = applyRestriction(allPaths, ['alg=',alg]);
    end
    
    if step ~= -1
        allPaths = applyRestriction(allPaths, ['/', step]);
    end
    
    if metric ~= -1
        allPaths = applyRestriction(allPaths, ['/', metric]);
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

