function [ pathToData ] = pathToRandomGraphData( N, P, ALG, nGraphs, stepNumber, makeNewDir)

    if nargin < 6
        makeNewDir = 1;
    end

    BASE = 'alternative generator/data';

    if makeNewDir
        createNewExperimentSetup(BASE, N, P, ALG);
    end
    
    if nargin < 5
        stepNumber = 0;
    end
    
    if stepNumber == 0
        stepNumber = '/raw';
    elseif stepNumber == 1
        stepNumber = '/cannon';   
    elseif stepNumber == 2
        stepNumber = '/results';
    else
        warning('Invalid Step Number');
    end
    
    N = ['/n=', num2str(N)];
    P = ['/p=', num2str(P)];
    ALG = ['/alg=', ALG];
    
    if nGraphs > 0
        if strfind(nGraphs, '.mat')
            nGraphs = ['/',num2str(nGraphs)];
        else
            nGraphs = ['/',num2str(nGraphs),'.mat'];
        end
    else
        nGraphs = '';
    end
        
    pathToData = [BASE, N, P, ALG, stepNumber, nGraphs];
    
end

