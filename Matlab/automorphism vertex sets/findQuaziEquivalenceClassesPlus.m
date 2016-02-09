function [ output_args ] = findQuaziEquivalenceClassesPlus( G )

    qec = findQuaziEquivalenceClasses(G);
    pathsPlus = cell(size(qec));
    
    for i = 1 : size(qec, 2)
        class = cell2mat(qec(i));
        if size(class, 2) > 1
            for j = 1 : size(class, 2)
                pathsPlus(class(j)) = {findExcessPathsFast(G, class(j))};
            end
            toEqual = cell2mat(pathsPlus(class(1)));
            equalClass = [];
            unequalClass = [];
            for j = 1 : size(class, 2)
                isEqual = 1 - any(toEqual - cell2mat(pathsPlus(class(j))));
                if (isEqual)
                    equalClass = horzcat(equalClass, class(j));
                else
                    unequalClass = horzcat(unequalClass, class(j));
                end
            end
            if (size(unequalClass, 2) > 0)
                qec(i) = {equalClass};
                qec = horzcat(qec(1 : i), {unequalClass}, qec(i+1:end));
            end
        end
    end
    
    output_args = qec;
end

