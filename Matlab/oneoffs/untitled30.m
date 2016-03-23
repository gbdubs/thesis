trialNo = 1;

for trialNo = 1 : 30
    disp(['Now creating trial number ', num2str(trialNo)]);
    for p = .05 : .05 : .95
        for v = 4 : 10
            createIdealRandomGraphData(v,p,1000,trialNo);
            createStandardRandomGraphData(v,p,1000,trialNo);
        end
    end
    pause(10);
end