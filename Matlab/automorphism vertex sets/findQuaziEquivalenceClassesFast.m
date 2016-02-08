function [ output_args ] = findQuaziEquivalenceClassesFast( G )
    dims = size(G);
    pathLength = dims(1);
    labeledKs = generateLabeledKsFast(G, pathLength);
    equivClasses = [];
    currentClass = labeledKs(1,pathLength+1);
    for i = 2 : dims(1)
        if (sum((labeledKs(i, 1:pathLength) - labeledKs(i-1,1:pathLength)) .^ 2) == 0)
            currentClass = horzcat(currentClass, labeledKs(i, 1+pathLength));
        else
            equivClasses = horzcat(equivClasses, {currentClass});
            currentClass = labeledKs(i, 1+pathLength);
        end
    end
    equivClasses = horzcat(equivClasses, {currentClass});
    output_args = equivClasses;
end

