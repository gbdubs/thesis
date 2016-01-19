function [ result ] = loadData( v, e , shouldAssign)
    
    if nargin < 3
        shouldAssign = 1;
    end

    if nargin < 2
        maxE = v * (v-1) / 2;
        running = [];
        for ei = 0 : maxE
            running = vertcat(running, loadData(v, ei, 0));
        end
        if shouldAssign
            assignin('base', ['data_',num2str(v)], running);
        end
        result = running;
        return;
    end

    relativePath = ['../data/smallgraphs/',num2str(v), '-', num2str(e),'.txt'];
    
    result = [];
    
    fid = fopen(relativePath);

    tline = fgets(fid);
    while ischar(tline)
        result = vertcat(result, tline);
        tline = fgets(fid);
    end

    fclose(fid);
    
    
    
    if shouldAssign
        varName = ['data_',num2str(v), '_', num2str(e)];
        assignin('base', varName, result);
    end
end

