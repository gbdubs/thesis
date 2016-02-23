function [ result ] = findDistributionOfMaximalDifferentiatingPower( graphset )
    result = zeros(size(graphset, 1), 1);
    for i = 1 : size(graphset, 1)
        result(i) = findMaximalPathsDifferentiatingPower(graph6(graphset(i,:)), 100);
    end 
end