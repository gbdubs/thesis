function calculateMetricOverRandomGraphData(targetMetric, data, saveTo, saveAs)
    
    command = [saveAs, ' = ',targetMetric,'(data);'];
    eval(command);
    
    try
        save(saveTo, saveAs, '-append');
    catch
        try
            save(saveTo, saveAs);
        catch
            mkdir([pwd,'/alternative generator/smalldata/',targetMetric]);
            save(saveTo, saveAs);
        end
    end
    
    disp(['Going to calculate ', targetMetric]);
    disp(size(data));
    disp(['Going to save to ', saveTo,' as ',saveAs]);
    disp('');
end

