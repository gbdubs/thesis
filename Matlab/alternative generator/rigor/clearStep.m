function [ allPaths ] = clearStep( n, p, alg, step, metric )

    function [ o ] = applyRestriction ( i, rest )
        o = i{~cellfun(@isempty,strfind(i, rest))};
    end

    allPaths = genpath('alternative generator/data')';

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
    
    if step ~= -1
        allPaths = applyRestriction(allPaths, ['/', metric]);
    end





end

