function [ allMetrics ] = findAllMetrics( )

    allMetrics = {};
    
    files = dir('alternative generator/metrics/')';
    
    for file = files
        fileName = strrep(file.name, '.m', '');
        fileName = strrep(fileName, '.', '');
        if numel(fileName) > 0
            allMetrics = horzcat(allMetrics, strsplit(fileName,'_'));
        end
    end
end

