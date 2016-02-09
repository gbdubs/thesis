function [result] = compareProbabilityDistribution( expected, actual , nTrials, confidenceLevel)
    % Fills in the missing Keys in both distributions.
    for k = expected.keys
        j = cell2mat(k);
        if ~actual.isKey(j)
            actual(j) = 0;
        end
    end
    
    for k = actual.keys
        j = cell2mat(k);
        if ~expected.isKey(j);
            expected(j) = 0;
        end
    end
    
    
    
    result = zeros(size(expected.keys, 2), 4);
    i = 1;
    for k = expected.keys
        j = cell2mat(k);
        e = expected(j);
        a = actual(j);
        sigma = norminv(1 - (confidenceLevel/2), 0, 1);
        stdDev = sqrt(e * (1-e) / nTrials);
        observedDifference = abs(a - e);
        z = observedDifference / stdDev;
        
        result(i, :) = [z, z > sigma, round(e * 10000), round(a * 10000)];
        
        i = i + 1;
    end
    
    result = sortrows(result);
    disp(result);
    
    attempts = size(result, 1);
    allFailed = sum(result(:, 2));
    disp(['Ran all of the ',num2str(attempts),' comparisons, and found that ',num2str(allFailed),' were outside of our expecations.']);
    
    
    probability = 1 - binocdf(allFailed, attempts, confidenceLevel);
    disp(['The Probability of such an occurance is : ', num2str(probability)]);
    if (probability > confidenceLevel / 2)
        disp('Which is not signifigant at the provided CL.');
    else
        disp('WHICH IS STATISTICALLY SIGNIFIGANT AT THE PROVIDED CL.');
    end
    
    
end

