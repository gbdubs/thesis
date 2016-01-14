function [ output_args ] = verifyPathsDefinesAutomorphismGroups( G )

    automorphs = findAllAutomorphisms(G);

    disp 'FOUND AUTOMORPHISMS';

    autoGroups = deduceAutomorphismGroupsFromAutomorphisms(automorphs);

    disp 'FOUND AUTO-GROUPS';

    pathsGroups = findQuaziEquivalenceClasses(G);

    disp 'FOUND PATHS-GROUPS';

    cellz = cell(1, size(G, 2));

    for i = 1 : size(pathsGroups, 2);
        mat = cell2mat(pathsGroups(i));
        for j = 1 : size(mat, 2)
            cellz(mat(j)) = pathsGroups(i);
        end
    end

    output_args = 1;
    
    for i = 1 : size(G, 2)
        a = transpose(sort(cell2mat(autoGroups(i))));
        p = sort(cell2mat(cellz(i)));

        d = a - p;
        if (all(d))
            disp(strcat('NOT OKAY!!! : A -->', mat2str(a), '    P --> ', mat2str(p)));
            output_args = -1;
        else 
            disp(strcat('OK :  A -->', mat2str(a), '    P --> ', mat2str(p)));
        end
    end
end

