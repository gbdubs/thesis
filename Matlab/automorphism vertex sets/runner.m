graphSet = data_8;

errors = 0;
for i = 1 : size(graphSet, 1)
    g = graph6(graphSet(i,:));
    result = verifyPathsDefinesAutomorphismGroups(g, 0);
    if (result == 1)
        disp(['ALL GOOD! ', num2str(i)]);
    else
        disp(['ERROR!ERROR!ERROR!ERROR!ERROR!ERROR!:  ', graphSet(i,:)]);
        errors = errors + 1;
    end
end

errors