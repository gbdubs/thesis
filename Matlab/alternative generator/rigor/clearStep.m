function clearStep( n, p, alg, step, metric , checkNumber)
    if nargin < 6
        checkNumber = -1;
    end

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
    
    
    
    expectedCheckNum = numel(allPaths);
    
    if checkNumber > 0
        if expectedCheckNum == checkNumber
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
        else
            disp([num2str(expectedCheckNum),': Checksum did not match input argument']);
        end
    else
        disp([num2str(expectedCheckNum),' different directories to be deleted. If correct, rerun with this check number']);
    end
end

