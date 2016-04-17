index = 0;
total = 40 * 9 * 7;
progressbar;
for trial = 1 : 30
    disp(['Starting trial ',num2str(trial)]);
    for p = .1 : .1 : .9
        for n = 4 : 10
            index = index + 1;
            progressbar(index / total);
            createBuildingCRandomGraphData(n,p,1000,trial);
            createBuildingDRandomGraphData(n,p,1000,trial);
            createBuildingERandomGraphData(n,p,1000,trial);
        end
    end
end