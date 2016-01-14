function [ output_args ] = equivalenceClassesToString( a )
    result = '';
    for i = 1 : size(a,2)
        result = strcat(result, mat2str(cell2mat(a(i))), '\n');
    end
    output_args = result;
end

