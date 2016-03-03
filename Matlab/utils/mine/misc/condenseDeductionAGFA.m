function [ o ] = condenseDeductionAGFA( c )
    o = {};
    for i = 1 : numel(c)
        temp1 = cell2mat(c(i))';
        same = 0;
        for j = 1 : numel(o)
            temp2 = cell2mat(o(j));
            if numel(temp1) == numel(temp2)
                if any(sort(temp1) == sort(temp2))
                    same = 1;
                end
            end
        end
        if ~same
            o = horzcat(o, {temp1});
        end
    end
end

