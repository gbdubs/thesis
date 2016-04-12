for trial = 1 : 30
    disp(['Trial = ', num2str(trial)]);
    for n = 4 : 10
        disp(['N = ', num2str(n)]);
        for p = .1 : .1 : .9
            disp(['P = ', num2str(p)]);
            createMinusOneARandomGraphData(n,p,1000,trial);
            createMinusOneBRandomGraphData(n,p,1000,trial);
            createMinusOneCRandomGraphData(n,p,1000,trial);
        end
    end
end