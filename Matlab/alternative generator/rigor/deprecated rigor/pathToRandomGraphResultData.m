function [ pathToData ] = pathToRandomGraphResultData( N, P, ALG, nGraphs, METRIC)

    BASE = 'alternative generator/data';

    N = ['/n=', num2str(N)];
    P = ['/p=', num2str(P)];
    ALG = ['/alg=', ALG];
    METRIC = ['/results/', METRIC];
    
    if nGraphs > 0
        if strfind(nGraphs, '.mat')
            nGraphs = ['/',num2str(nGraphs)];
        else
            nGraphs = ['/',num2str(nGraphs),'.mat'];
        end
    else
        nGraphs = '';
    end
        
    pathToData = [BASE, N, P, ALG, METRIC, nGraphs];
    
end

