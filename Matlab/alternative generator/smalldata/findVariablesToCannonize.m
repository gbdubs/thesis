function [ varsToCannonize , varsToResult ] = findVariablesToCannonize(rawVars, cannonVars, metric1, metric2)
    rawVars = cellfun(@(x) x(numel(metric1)+2:end), rawVars, 'UniformOutput', 0);
    cannonVars = cellfun(@(x) x(numel(metric2)+2:end), cannonVars, 'UniformOutput', 0);
    diff = setdiff(rawVars, cannonVars)';
    varsToCannonize = cell(1, numel(diff));
    varsToResult = cell(1, numel(diff));
    if numel(diff) > 0
        i = 1;
        for d = diff
            varsToCannonize(i) = {[metric1,'_',cell2mat(d)]};
            varsToResult(i) = {[metric2,'_',cell2mat(d)]};
            i = i + 1;
        end
    end
end