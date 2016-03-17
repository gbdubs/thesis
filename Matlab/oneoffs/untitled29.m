
for i = 1 : 30
    for n = 4 : 10
        disp([num2str(n), ' ', num2str(i)]);
        for p = .1 : .1 : .9
            StandardRandomGenerator(n,p,10000+i+1,1);
            IdealRandomGenerator(n, p, 10000+i+1,1);
        end 
    end
end
updateAllPathsData();
cannonizeRandomGraphData();
updateAllPathsData();
calculateAllMetrics();
updateAllPathsData();