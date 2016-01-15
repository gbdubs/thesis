function [ output_args ] = verifyPathsDefinesAutomorphismGroups( G , shouldDisp )
    if (nargs == 1)
        shouldDisp = 0;
    end

    automorphs = findAllAutomorphisms(G);
    autoGroups = deduceAutomorphismGroupsFromAutomorphisms(automorphs);
    pathsGroups = findQuaziEquivalenceClasses(G);

    pathCells = cell(1, size(G, 2));

    for i = 1 : size(pathsGroups, 2);
        mat = cell2mat(pathsGroups(i));
        for j = 1 : size(mat, 2)
            pathCells(mat(j)) = pathsGroups(i);
        end
    end

    output_args = 1;
    
    for i = 1 : size(G, 2)
        a = transpose(sort(cell2mat(autoGroups(i))));
        p = sort(cell2mat(pathCells(i)));

        d = a - p;
        if (all(d))
            if shouldDisp
                disp(strcat('NOT OKAY!!! : A -->', mat2str(a), '    P --> ', mat2str(p)));
            end
            output_args = -1;
        else
            if shouldDisp
                disp(strcat('OK :  A -->', mat2str(a), '    P --> ', mat2str(p)));
            end
        end
    end
end

