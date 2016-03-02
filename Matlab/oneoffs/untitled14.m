% Verifies the generalized probability distribution targeting problem's
% results.


for i = 1 : 10000
    vec = round(15 * rand(1,15));
    target = rand() * 15;

    probs = solveGeneralizedProbabilityDistributionTargetingProblem(vec, target);

    if any(size(probs) ~= size(vec))
        disp('size mismatch');
    end
    
    
    expectation = dot(vec, probs) - target;
    
    
    
    if (abs(expectation) > 1 / 1000)
        disp('FAILURE');
    end
end
    