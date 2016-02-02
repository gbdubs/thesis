function [ result ] = loadDataRegular( v, e , shouldAssign)
    
    if nargin < 3
        shouldAssign = 1;
    end

    if nargin < 2
        maxE = v-1;
        running = [];
        for ei = 0 : maxE
            running = vertcat(running, loadDataRegular(v, ei, 0));
        end
        if shouldAssign
            assignin('base', ['R_data_',num2str(v)], running);
        end
        result = running;
        return;
    end
    
    % Allows processing on both the small set, and the larger set on the
    % vertica IMacs.
    relativePath = ['../../graphs/R-',num2str(v), '-', num2str(e),'.txt'];
    if exist(relativePath, 'file') ~= 2
        relativePath = ['../data/reggraphs/R-',num2str(v), '-', num2str(e),'.txt'];
    end
    
    if exist(relativePath, 'file') ~= 2
        disp(['The File You Are Looking For Does Not Exist: [', relativePath, ']']);
        return;
    end
    
    result = [];
    
    fid = fopen(relativePath);

    
    
    tline = fgets(fid);
    while ischar(tline)
        result = vertcat(result, tline);
        tline = fgets(fid);
    end

    fclose(fid);
    
    if shouldAssign
        varName = ['R_data_',num2str(v), '_', num2str(e)];
        assignin('base', varName, result);
    end
end

