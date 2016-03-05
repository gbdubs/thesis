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
            greaterThanClass = [];
            equalClass = [];
            lessThanClass = [];
            for j = 1 : size(class, 2)
                % COMPARE HERE!!!!!
                diff = toEqual - cell2mat(pathsPlus(class(j)));
                temp = find(diff);
                % IS EQUAL
                if numel(temp) == 0
                    equalClass = horzcat(equalClass, class(j));
                elseif sign(diff(temp(1))) == -1
                    lessThanClass = horzcat(lessThanClass, class(j));
                elseif sign(diff(temp(1))) == 1
                    greaterThanClass = horzcat(greaterThanClass, class(j));
                end
            end
            if numel(lessThanClass) > 0
                if numel(lessThanClass) > 0
                    qec = horzcat(qec(1:i-1), {lessThanClass}, {equalClass}, {greaterThanClass}, qec(i+1:end));
                else 
                    qec = horzcat(qec(1:i-1), {lessThanClass}, {equalClass}, qec(i+1:end));
                end
            elseif numel(greaterThanClass) > 0
                qec = horzcat(qec(1:i-1), {equalClass}, {greaterThanClass}, qec(i+1:end));
            end
        end
    end
    
    output_args = qec;
end

