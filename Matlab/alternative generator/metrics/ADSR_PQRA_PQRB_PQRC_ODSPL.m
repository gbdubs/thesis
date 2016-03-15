function [ ADSR, PQRA, PQRB, PQRC, ODSPL ] = ADSR_PQRA_PQRB_PQRC_ODSPL( graphSet )
% ADSR = Average Degree Sequence Range
% PQRA = Percentage Quazi Regular A (Range of the degree sequence <= 1)
% PQRB = Percentage Quazi Regular A (Range of the degree sequence <= 2)
% PQRC = Percentage Quazi Regular B (Range of the degree sequence < sqrt(N))
% ODSPL = Overall Degree Sequence Poisson distribution Lambda

    nGraphs = size(graphSet, 1);
    N = size(graph6(graphSet(1,:)), 1);
    while N <= 2
        N = size(graph6(graphSet(ceil(size(graphSet, 1) * rand),:)), 1);
    end
    sqrtN = sqrt(N);

    function [ isQRA ] = isItQRA(DSR)
        isQRA = DSR <= 1;
    end

    function [ isQRA ] = isItQRB(DSR)
        isQRA = DSR <= 2;
    end

    function [ isQRC ] = isItQRC(DSR)
        isQRC = DSR <= sqrtN;
    end

    nDSR = 0;
    nQRA = 0;
    nQRB = 0;
    nQRC = 0;
    
    allDS = zeros(nGraphs * N, 1);

    for i = 1 : nGraphs
        DS = sum(graph6(graphSet(i,:)));
        DSR = max(DS) - min(DS);
        nDSR = nDSR + DSR;
        nQRA = nQRA + isItQRA(DSR);
        nQRB = nQRB + isItQRB(DSR);
        nQRC = nQRC + isItQRC(DSR);
        allDS((i-1)*N+1:i*N) = DS;
    end

    PQRA = nQRA / nGraphs;
    PQRB = nQRB / nGraphs;
    PQRC = nQRC / nGraphs;
    ADSR = nDSR / nGraphs;
    
    pd = fitdist(allDS, 'Poisson');
    
    ODSPL = pd.lambda;
end

