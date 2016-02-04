function [ result ] = load1Sparse( v, nGraphs, shouldAssign)
    
    if nargin < 3
        shouldAssign = 1;
    end

    if nargin < 2
        disp('ERR : Please put in a number of graphs to load');
    end
    
    relativePath = ['test graphs/1Sparse/',num2str(v), '#', num2str(nGraphs),'.txt'];
    if exist(relativePath, 'file') ~= 2
        disp(['ERR : Couldnt Seem to Find The File You are Referencing... [', relativePath, ']']);
    end
    
    wordSize = size(graph6Encode(zeros(v, v)),2);
    
    result = char(zeros(nGraphs, wordSize));
    index = 1;
    
    fid = fopen(relativePath);

    tline = fgets(fid);
    while ischar(tline)
        result(index, :) = strtrim(tline);
        tline = fgets(fid);
        index = index + 1;
    end

    fclose(fid);
    
    if shouldAssign
        varName = ['sparse1_',num2str(v), '_', num2str(nGraphs)];
        assignin('base', varName, result);
    end
end

