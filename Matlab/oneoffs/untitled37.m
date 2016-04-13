for trial = 1 : 30
    disp(['Trial = ', num2str(trial)]);
    for n = 4 : 10
        disp(['N = ', num2str(n)]);
        for p = .1 : .1 : .9
            disp(['P = ', num2str(p)]);
            createBuildingARandomGraphData(n,p,1000,trial);
            createBuildingBRandomGraphData(n,p,1000,trial);
            createVerificationRandomGraphData(n,p,1000,trial);
            createWinnerRandomGraphData(n,p,1000,trial);
        end
    end
end

performAllProcessingOnAlgorithm('BuildingA');
performAllProcessingOnAlgorithm('BuildingB');
performAllProcessingOnAlgorithm('Verification');
performAllProcessingOnAlgorithm('Winner');