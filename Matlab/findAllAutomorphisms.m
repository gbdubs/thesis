function [ output_args ] = findAllAutomorphisms( G )
% Very much a WIP. Not a final product.

    function [ result ] = isomorphismIsIncomplete()
        result = 0;
        for index = 1 : size(isomorphism, 2)
            if (isomorphism(index) == 0)
                result = 1;
            end
        end
    end

    function [ result ] = qecSizeError()
        nA = size(qecA, 2);
        nB = size(qecB, 2);
        if (nA ~= nB)
            result = 0;
            return;
        end
        
        cellszA = cell2mat(cellfun(@size, qecA, 'uni', false));
        cellszB = cell2mat(cellfun(@size, qecA, 'uni', false));
        diff = cellszA - cellszB;
        result = all(diff(:) ~= 0);
    end

    function subdivideEquivalenceClassesBasedOnNewLink(a, b)
        function subdivideEquivalenceClassBasedOnNewLink(index)
            aClass = cell2mat(qecA(index));
            adjacentA = [];
            nonAdjacentA = [];
            for i = 1 : size(aClass, 2)
                if (G(a, aClass(i)))
                    adjacentA = horzcat(adjacentA, aClass(i));
                else
                    nonAdjacentA = horzcat(nonAdjacentA, aClass(i));
                end
            end
            if (size(adjacentA, 2) > 0 && size(nonAdjacentA, 2) > 0)
                qecA(index) = {adjacentA};
                qecA = horzcat(qecA, {nonAdjacentA});   
            end
            
            bClass = cell2mat(qecB(index));
            adjacentB = [];
            nonAdjacentB = [];
            for i = 1 : size(bClass, 2)
                if (G(b, bClass(i)))
                    adjacentB = horzcat(adjacentB, bClass(i));
                else
                    nonAdjacentB = horzcat(nonAdjacentB, bClass(i));
                end
            end
            if (size(adjacentB, 2) > 0 && size(nonAdjacentB, 2) > 0)
                qecB(index) = {adjacentB};
                qecB = horzcat(qecB, {nonAdjacentB});   
            end
        end
        
        
        
        idx = 1;
        while (idx <= size(qecA, 2))
            matA = cell2mat(qecA(idx));
            matB = cell2mat(qecB(idx));
            if (sum(find(a==matA))>0)
                matA = matA(matA ~= a);
                matB = matB(matB ~= b);
                qecA(idx) = {matA};
                qecB(idx) = {matB};
            end
            subdivideEquivalenceClassBasedOnNewLink(idx);
            idx = idx + 1;
        end
    end

    function assignAllKnowns()
        idx = 1;
        while (idx <= size(qecA, 2))
            aMat = cell2mat(qecA(idx));
            bMat = cell2mat(qecB(idx));
            if (size(aMat, 1) > 0)
                a = aMat(1);
                b = bMat(1);
                if (size(aMat, 2) == 1 && isomorphism(a) == 0)
                    isomorphism(a) = b;
                    subdivideEquivalenceClassesBasedOnNewLink(a,b);
                    idx = 0;
                end
            end
            idx = idx + 1;
        end
    end

    function makeRandomAssignment()
        idx = 1;
        while (idx <= size(qecA, 2))
            aMat = cell2mat(qecA(idx));
            bMat = cell2mat(qecB(idx));
            if (size(aMat, 1) > 0)
                a = aMat(1);
                b = bMat(size(bMat, 2));
                if (isomorphism(a) == 0)
                    isomorphism(a) = b;
                    subdivideEquivalenceClassesBasedOnNewLink(a,b);
                    return;
                end
            end
            idx = idx + 1;
        end
    end
        

n = size(G, 1);

qecA = findQuaziEquivalenceClasses(G);
qecB = findQuaziEquivalenceClasses(G);

isomorphism = zeros(1, n);

while (isomorphismIsIncomplete())
    if (qecSizeError())
        output_args = NULL;
        return;
    end
    assignAllKnowns();
    makeRandomAssignment();
end

output_args = isomorphism;

end

