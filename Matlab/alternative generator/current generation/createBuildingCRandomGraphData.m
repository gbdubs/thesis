function [ graphSet ] = createBuildingCRandomGraphData( v, p, nGraphs, runNo)
        
    function [ pMat ] = generateProbabilityMatrixFromMat(A)
        pMat = ones(size(A)) - eye(size(A));
        degSeq = sum(A);
        toAdd = repmat(max(degSeq) - degSeq, size(A,1), 1);
        pMat = pMat + toAdd + toAdd';
        pMat = pMat * (1 - A);
        mask = (1-(A==1 | eye(size(A))));
        pMat = pMat .* mask;
        pMat = pMat / sum(sum(pMat));
    end

    function [ A ] = addEdgeByProbabilityMatrix(A, P)
        r = rand();
        index = 1;
        while r > P(index)
            r = r - P(index);
            index = index + 1;
        end
        A(index) = 1;
        index = index - 1;
        A(floor(index/size(A,1))+1,mod(index,size(A,1))+1) = 1;
    end

    function [ A ] = createBuildingGraph(v, p)

        nEdges = binornd(v*(v-1)/2, p);

        A = zeros(v, v);
    
    	P = generateProbabilityMatrixFromMat(A);
        
        while nEdges > 0
            A = addEdgeByProbabilityMatrix(A,P);
            P = generateProbabilityMatrixFromMat(A);
            nEdges = nEdges - 1;
        end
    end
       
    A = graph6Encode(zeros(v));
    
    graphSet = char(zeros(nGraphs, size(A, 2)));
    for i = 1 : nGraphs
        graphSet(i,:) = graph6Encode(createBuildingGraph(v,p));
    end

    saveRandomGraphDataResult(graphSet,v,p,'BuildingC','RAW',nGraphs, runNo);
    
end