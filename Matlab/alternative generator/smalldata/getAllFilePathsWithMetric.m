function [ allFiles ] = getAllFilePathsWithMetric( metric , fileNamesOnly)
    if numel(nargin) < 2
        fileNamesOnly = 1;
    end
    
    path = [pwd,'/alternative generator/smalldata/',metric];
    files = dir(path)';
    allFiles = cell(1,numel(files));
    index = 1;
    for f = files
        if ~f.isdir
            if fileNamesOnly
                allFiles(index) = {f.name};
            else
                allFiles(index) = {[path,'/',f.name]};
            end
            index = index + 1;
        end
    end
    allFiles = allFiles(1:index-1);
end