function generateDataForNautyTimingComparison( n , p, nTrials, trialNo)


    graphSet = createStandardRandomGraphData(n, p, nTrials);
    fid = fopen(['nauty timing comparison/data/Standard',num2str(n),'_',num2str(round(p*100)),'_',num2str(nTrials),'_',num2str(trialNo),'.txt'],'wt');
    progressbar;
    for i = 1 : size(graphSet, 1)
        if (mod(i, 100) == 0)
            progressbar(i / size(graphSet, 1));
        end
        fprintf(fid, '%s\n', graphSet(i,:));
    end
    fclose(fid);
    close all;

    graphSet = createIdealRandomGraphData(n, p, nTrials);
    fid = fopen(['nauty timing comparison/data/Ideal',num2str(n),'_',num2str(round(p*100)),'_',num2str(nTrials),'_',num2str(trialNo),'.txt'],'wt');
    progressbar;
    for i = 1 : size(graphSet, 1)
        if (mod(i, 100) == 0)
            progressbar(i / size(graphSet, 1));
        end
        fprintf(fid, '%s\n', graphSet(i,:));
    end
    fclose(fid);
    close all;
    
    
end

