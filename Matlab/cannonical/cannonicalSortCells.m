function [ cellz ] = cannonicalSortCells( cellz )
    swapped = 1;
    while swapped
        swapped = 0;
        for index = 1 : size(cellz, 2) - 1
            s1 = size(cell2mat(cellz(index)),2);
            s2 = size(cell2mat(cellz(index+1)),2);
            if (s1 > s2)
                temp = cellz(index);
                cellz(index) = cellz(index+1);
                cellz(index+1) = temp;
                swapped = 1;
            end
        end
    end
end