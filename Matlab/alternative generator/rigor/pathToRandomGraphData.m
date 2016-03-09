function [ pathToData ] = pathToRandomGraphData( N, P, ALG, nGraphs, stepNumber )
    
    BASE = 'alternative generator/data';

    createNewExperimentSetup(BASE, N, P, ALG);

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
    nGraphs = ['/',num2str(nGraphs),'.mat'];
    
    pathToData = [BASE, N, P, ALG, stepNumber, nGraphs];
    
end

