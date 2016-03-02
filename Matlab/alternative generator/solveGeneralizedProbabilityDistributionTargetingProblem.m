function [ projection ] = solveGeneralizedProbabilityDistributionTargetingProblem( weights, weightTarget )

    if (numel(weights) == 1 || numel(unique(weights)) == 1)
        projection = ones(size(weights)) / numel(weights);
        return;
    end


    if (numel(unique(weights)) ~= numel(weights))
        [weightCounts, uniqueWeights] = hist(weights, unique(weights));
        if (numel(uniqueWeights) < 3)
            projection = ones(size(weights)) / numel(weights);
        else 
            uniqueProj = solveNonUniqueCountCase(uniqueWeights', weightCounts, weightTarget);

            projection = zeros(size(weights));
            for i = 1 : numel(uniqueWeights)
                projection(weights == uniqueWeights(i)) = uniqueProj(i) / weightCounts(i);
            end
        end
        % Turn this off if you want to pass the tests!
        projection = makeReasonable(projection);
    else
        projection = solveUniqueCase(weights, weightTarget);
        % Turn this off if you want to pass the tests!
        projection = makeReasonable(projection);
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
        nonZeroWeights = find(weights ~= 0);
        weight1 = weights(nonZeroWeights(1));
        partnerWeights = find(weights ~= 0 & weights ~= weight1);
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

        weights(replacementIndex) = [];
        counts(replacementIndex) = [];

        point = counts;
        point = point / sum(counts);

        normalVector = weights - replacementWeight;
        orthaNormalVector = normalVector / norm(normalVector);

        planePoint = zeros(size(weights));
        nonZeroWeights = find(weights ~= 0);
        weight1 = weights(nonZeroWeights(1));
        partnerWeights = find(weights ~= 0 & weights ~= weight1);
        
        weight2 = weights(partnerWeights(1));

        p1 = (weightTarget - weight2) / (weight1 - weight2);
        p2 = 1 - p1;

        planePoint(nonZeroWeights(1)) = p1;
        planePoint(partnerWeights(1)) = p2;

        projection = point - orthaNormalVector * dot(point - planePoint, orthaNormalVector);

        projection = [projection(1 : replacementIndex-1), 1 - sum(projection), projection(replacementIndex + 1 : end)];
    end
    
    function [ p ] = makeReasonable ( p )
        p = min(p, 1);
        p = max(p, 0);
        p = p / sum(p);
    end

end

