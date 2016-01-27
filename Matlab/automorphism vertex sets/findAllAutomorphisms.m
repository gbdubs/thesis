function [ output_args ] = findAllAutomorphisms( G )

allAutomorphisms = {};

if (sum(sum(G)) == 0 || sum(sum(G)) == (size(G, 1) * (size(G, 1) - 1)))
    for loopvar = 0 : size(G, 1) - 1
        automorph = 1 : size(G, 1);
        automorph = mod(automorph + loopvar, size(G, 1));
        allAutomorphisms = horzcat(allAutomorphisms, {automorph});
    end
    output_args = allAutomorphisms;
    return;
end

    function [ automorphism ] = generateAutomorphismGiven(qecA, qecB, automorph, aaa, bbb)
        if (nargin == 5)
            subdivideEquivalenceClassesBasedOnNewLink(aaa,bbb);
        end
        
        function [ result ] = automorphismIsIncomplete()
            result = 0;
            for index = 1 : size(automorph, 2)
                if (automorph(index) == 0)
                    result = 1;
                end
            end
        end

        function [ result ] = qecSizeError()
            nA = size(qecA, 2);
            nB = size(qecB, 2);
            if (nA ~= nB)
                result = 1;
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
                if qecSizeError()
                    return
                end
                idx = idx + 1;
            end
        end

        function assignAllKnowns()
            idx = 1;
            while (idx <= size(qecA, 2) && idx <= size(qecB, 2))
                aMat = cell2mat(qecA(idx));
                bMat = cell2mat(qecB(idx));
                if (size(aMat, 1) > 0)
                    a = aMat(1);
                    b = bMat(1);
                    if (size(aMat, 2) == 1 && automorph(a) == 0)
                        automorph(a) = b;
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
                    nBees = size(bMat, 2);
                    
                    b = bMat(nBees);
                    if (automorph(a) == 0)
                        if (nBees >= 2)
                            for newBee = 1 : nBees-1
                                modAutomorph = automorph;
                                modAutomorph(a) = bMat(newBee);
                                modQecA = qecA;
                                modQecB = qecB;
                                generateAutomorphismGiven(modQecA, modQecB, modAutomorph, a, bMat(newBee))
                            end
                        end
                        automorph(a) = b;
                        subdivideEquivalenceClassesBasedOnNewLink(a,b);
                        return;
                    end
                end
                idx = idx + 1;
            end
        end

        while (automorphismIsIncomplete())
            if (qecSizeError())
                return;
            end
            assignAllKnowns();
            makeRandomAssignment();
        end
        
        allAutomorphisms = horzcat(allAutomorphisms, {automorph});
        
    end

n = size(G, 1);

QECA = findQuaziEquivalenceClasses(G);
QECB = findQuaziEquivalenceClasses(G);

AUTOM = zeros(1, n);

generateAutomorphismGiven(QECA, QECB, AUTOM);

output_args = allAutomorphisms;

end

