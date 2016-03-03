function [ projection ] = solveGeneralizedProbabilityDistributionTargetingProblem( weights, weightTarget )

    if (min(weights) > weightTarget || max(weights) < weightTarget)
        warning('There is no solution here. Line 4: Target Weight Lies Outside of Weight Range.');
        projection = ones(size(weights)) / numel(weights);
        return;
    end

    nUniqueElements = numel(unique(weights));
    
    if (nUniqueElements < 3)
       
        if nUniqueElements == 0
            warning('There is no solution here. Line 14: Zero Elements provided.');
        elseif nUniqueElements == 1
            if weights(1) ~= weightTarget
                warning('There is no solution here. Line 17: One Element provided which did not match the target weight.');
            end
            projection = ones(size(weights)) / numel(weights);
        else % nUniqueElements == 2
            uniqueEls = unique(weights);
            w1 = uniqueEls(1);
            w2 = uniqueEls(2);
            
            prob2 = (weightTarget - w1) / (w2 - w1);
            prob1 = 1 - prob2;
            
            projection = zeros(size(weights));
            projection(weights == w1) = prob1 / numel(find(weights == w1));
            projection(weights == w2) = prob2 / numel(find(weights == w2));
        end
        projection = makeReasonable(weights, weightTarget, projection);
        return;
    end


    if (numel(unique(weights)) ~= numel(weights))
        [weightCounts, uniqueWeights] = hist(weights, unique(weights));
        if (numel(uniqueWeights) < 3)
            projection = ones(size(weights)) / numel(weights);
        else 
            uniqueProj = solveNonUniqueCountCase(uniqueWeights, weightCounts, weightTarget);

            projection = zeros(size(weights));
            for i = 1 : numel(uniqueWeights)
                projection(weights == uniqueWeights(i)) = uniqueProj(i) / weightCounts(i);
            end
        end
        % Turn this off if you want to pass the tests!
        projection = makeReasonable(weights, weightTarget, projection);
    else
        projection = solveUniqueCase(weights, weightTarget);
        % Turn this off if you want to pass the tests!
        projection = makeReasonable(weights, weightTarget, projection);
    end
    
    
    
    function [ projection ] = solveUniqueCase(weights, weightTarget)
        
        nonZeroWeights = find(weights ~= 0);
        replacementIndex = nonZeroWeights(end);
        replacementWeight = weights(replacementIndex);

        weights(replacementIndex) = [];

        point = ones(1, numel(weights));
        point = point / numel(weights);

        normalVector = weights - replacementWeight;
        orthaNormalVector = normalVector / norm(normalVector);

        planePoint = zeros(size(weights));
        nonZeroWeights = find(weights ~= replacementWeight);
        weight1 = weights(nonZeroWeights(1));
        partnerWeights = find(weights ~= replacementWeight & weights ~= weight1);
        weight2 = weights(partnerWeights(1));

        p1 = (weightTarget - weight2) / (weight1 - weight2);
        p2 = 1 - p1;

        planePoint(nonZeroWeights(1)) = p1;
        planePoint(partnerWeights(1)) = p2;

        projection = point - orthaNormalVector * dot(point - planePoint, orthaNormalVector);

        projection = [projection(1 : replacementIndex-1), 1 - sum(projection), projection(replacementIndex + 1 : end)];
    end


    function [ projection ] = solveNonUniqueCountCase(weights, counts, weightTarget) 
        
        nonZeroWeights = find(weights ~= 0);
        replacementIndex = nonZeroWeights(end);
        replacementWeight = weights(replacementIndex);

        

        point = counts;
        point = point / sum(counts);
        
        weights(replacementIndex) = [];
        counts(replacementIndex) = [];
        point(replacementIndex) = [];

        normalVector = weights - replacementWeight;
        orthaNormalVector = normalVector / norm(normalVector);

        planePoint = zeros(size(weights));
        nonZeroWeights = find(weights ~= replacementWeight);
        weight1 = weights(nonZeroWeights(1));
        partnerWeights = find(weights ~= replacementWeight & weights ~= weight1);
        
        weight2 = weights(partnerWeights(1));

        p1 = (weightTarget - weight2) / (weight1 - weight2);
        p2 = 1 - p1;

        planePoint(nonZeroWeights(1)) = p1;
        planePoint(partnerWeights(1)) = p2;

        projection = point - orthaNormalVector * dot(point - planePoint, orthaNormalVector);

        projection = [projection(1 : replacementIndex-1), 1 - sum(projection), projection(replacementIndex + 1 : end)];
    end
    
    function [ result ] = makeReasonable ( weights, weightTarget, probDist )
        nonZero = find(probDist >= 0);
        if numel(nonZero) ~= numel(weights)
            modWeights = weights(nonZero);

            modProbDist = solveGeneralizedProbabilityDistributionTargetingProblem(modWeights, weightTarget);

            result = zeros(size(probDist));
            result(nonZero) = modProbDist;
        else
            result = probDist;
        end
    end

end

