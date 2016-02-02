function [ overall_confirmation ] = testAugmentationHypothesisOne( A )
% If we have a graph G with a vertex (a) and a vertex (b), 
% and (a) and (b) are copaths, 

% Then if we take add a new vertex (c) and add it to G, and
% create G' (by connecting a-c) and G'' (by connecting b-c)
% G'' and G' will be copaths graphs.

% Returns 1 if the graph behaves as expected (the hypothesis is true)
    
    v = size(A, 1);
    
    function [ subcase_confirmed ] = testOnSubCase(a, b)
    
        GP = augmentGraphWithNewVertex(A, a);
        GPP = augmentGraphWithNewVertex(A, b);

        pathsGP = generateLabeledKs(GP, v);
        pathsGPP = generateLabeledKs(GPP, v);
        
        diff = pathsGP(1:v, 1:v) - pathsGPP(1:v, 1:v);
        
        subcase_confirmed = 1 - any(any(diff));
        
    end
    
    qec = findQuaziEquivalenceClasses(A);
    
    toTest = generatePairsFromClasses(qec);
    
    failures = [];
    overall_confirmation = 1;
    for i = 1 : size(toTest, 1)
        if (testOnSubCase(toTest(i,1), toTest(i, 2)) == 1)
            
        else
            overall_confirmation = 0;
            failures = horzcat(failures, i);
        end
    end
    
    if (size(failures, 2) > 0)
        disp(['FAILURES!!!', mat2str(failures)]);
    end
    
end

