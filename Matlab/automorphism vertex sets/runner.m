graphSet = data_8;

errors = 0;

errorCases = {};

for i = 2 : size(graphSet, 1)
    g = graph6(graphSet(i,:));
    result = verifyPathsDefinesAutomorphismGroups(g, 0);
    if (result == 1)
        disp(['ALL GOOD! ', num2str(i)]);
    else
        disp(['ERROR!ERROR!ERROR!ERROR!ERROR!ERROR!:  ', graphSet(i,:)]);
        errors = errors + 1;
        errorCases = horzcat(errorCases, graphSet(i,:));
    end
end

errors
