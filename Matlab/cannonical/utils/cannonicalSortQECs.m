function [ cellz ] = cannonicalSortQECs( A, cellz )

    nClasses = size(cellz, 2);

    interesting = zeros(nClasses, nClasses);
    
    for i = 1 : nClasses
        for j = i+1 : nClasses
            idx = horzcat(cell2mat(cellz(i)),cell2mat(cellz(j)));
            subgraph = A(idx, idx);
            nEdges = sum(sum(subgraph));
            max = size(idx, 2) * (size(idx, 2) - 1) / 2;
            interestingPair = nEdges > 0 && nEdges < max;
            interesting(i, j) = interestingPair;
            interesting(j, i) = interestingPair;
        end
    end





% 
%     swapped = 1;
%     while swapped
%         swapped = 0;
%         for index = 1 : size(cellz, 2) - 1
%             s1 = size(cell2mat(cellz(index)),2);
%             s2 = size(cell2mat(cellz(index+1)),2);
%             if (s1 > s2)
%                 temp = cellz(index);
%                 cellz(index) = cellz(index+1);
%                 cellz(index+1) = temp;
%                 swapped = 1;
%             end
%         end
%     end
end