function [ newCells ] = cannonicalSortQECs( A, qec )

    nClasses = size(qec, 2);

    interesting = zeros(nClasses, nClasses);
    
    for i = 1 : nClasses
        m1 = cell2mat(qec(i));
        for j = i+1 : nClasses
            subgraph = A(m1, cell2mat(qec(j)));
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
        if (numel(order) < index)
            order = horzcat(order, min(setdiff(1:nClasses, order)));
        end
        examining = order(index);
        interested = setdiff(find(interesting(examining,:)), order);
        order = horzcat(order, interested);
        index = index + 1;
    end
    order = horzcat(order, setdiff(1:size(interesting,2), order));
    
    newCells = cell(size(qec));

    for i = 1 : size(order, 2)
        newCells(i) = qec(order(i));
    end
        
end