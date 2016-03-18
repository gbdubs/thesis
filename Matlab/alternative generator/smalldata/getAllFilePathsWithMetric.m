function [ allFiles ] = getAllFilePathsWithMetric( metric )
    path = [pwd,'/alternative generator/smalldata/',metric];
    files = dir(path)';
    
    allFiles = cell(numel(files),1);
    index = 1;
    for f = files
        if ~f.isdir
            allFiles(index) = {[path,'/',f.name]};
            index = index + 1;
        end
    end
    allFiles = allFiles(1:index-1);
    
end