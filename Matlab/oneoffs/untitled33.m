for n = 4 : 10
    for p = .1 : .1 : .9
        for nTrial = 6 : 30
            createMinusOneRandomGraphData(n,p,1000,nTrial);
        end
    end
end

masterCalculator;
masterCalculator;