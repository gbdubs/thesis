function [ newCells ] = cannonicalSortQECs( A, cellz )

    nClasses = size(cellz, 2);

    interesting = zeros(nClasses, nClasses);
    
    for i = 1 : nClasses
        for j = i+1 : nClasses
            subgraph = A(cell2mat(cellz(i)), cell2mat(cellz(j)));
            nEdges = sum(sum(subgraph));
            max = size(subgraph, 1) * size(subgraph, 2);
            interestingPair = nEdges > 0 && nEdges < max;
            interesting(i, j) = interestingPair;
            interesting(j, i) = interestingPair;
        end
    end

    order = 1;
    index = 1;
    while size(order, 2) < size(interesting, 2)
        examining = order(index);
        interested = setdiff(find(interesting(examining,:)), order);
        order = horzcat(order, interested);
        index = index + 1;
    end
    
    newCells = cell(size(cellz));

    for i = 1 : size(order, 2)
        newCells(i) = cellz(order(i));
    end
        
end