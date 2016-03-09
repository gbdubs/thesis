function [ result ] = getListOfRandomGraphFileNames(stepNumber)

    if stepNumber == 0
        stepNumber = 'raw';
    elseif stepNumber == 1
        stepNumber = 'cannon';
    elseif stepNumber == 2
        stepNumber = 'results';
    end

    dirs = {};

    p1 = 'alternative generator/data';
    d1 = dir(p1)';
    nFiles = 0;
    
    for f1 = d1
        if numel(f1.name) > 2 && f1.isdir
            p2 = [p1,'/',f1.name];
            d2 = dir(p2)';
            for f2 = d2
                if numel(f2.name) > 2 && f2.isdir
                    p3 = [p2, '/', f2.name];
                    d3 = dir(p3)';
                    for f3 = d3
                        if numel(f3.name) > 2 && f3.isdir
                            p4 = [p3, '/', f3.name];
                            dirs = [dirs, {p4}];
                            temp = dir([p4, '/', stepNumber]);
                            nFiles = nFiles - 2 + numel(temp);
                        end
                    end
                end
            end
        end 
    end
    
    result = cell(nFiles, 4);
    idx = 1;
    
    for i = 1 : numel(dirs)
        load([dirs{i}, '/variables.mat']);
        temp = dir([dirs{i},'/',stepNumber]);
        for j = 1 : numel(temp)
            fileName = temp(j).name;
            if numel(fileName) > 2
                nGraphs = str2num(strrep(fileName,'.mat',''));
                result(idx, :) = [{N}, {P}, {ALG}, {nGraphs}];
                idx = idx + 1;
            end
        end
    end
    
    sortrows(result);
end

