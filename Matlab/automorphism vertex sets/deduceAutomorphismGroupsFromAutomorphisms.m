function [ output_args ] = deduceAutomorphismGroupsFromAutomorphisms( auts )

    nAut = size(auts, 2);
    v = size(cell2mat(auts(1)),2);

    mat = zeros(nAut, v);
    
    for i = 1 : nAut
        mat(i,:) = cell2mat(auts(i));
    end
    
    cellz = cell(1, v);
    
    for i = 1 : v
        cellz(i) = {unique(mat(:, i))};
    end
    
    output_args = cellz;
end

