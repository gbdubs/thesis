function [ allMetrics ] = findAllMetrics( )

    allMetrics = {};
    
    files = dir('alternative generator/metrics/')';
    
    for file = files
        firstchar = file.name(1);
        if numel(strfind(file.name, '._')) == 0 && firstchar ~= '.'
            fileName = strrep(file.name, '.m', '');
            fileName = strrep(fileName, '.', '');
            if numel(fileName) > 0
                allMetrics = horzcat(allMetrics, strsplit(fileName,'_'));
            end
        end
    end
end

