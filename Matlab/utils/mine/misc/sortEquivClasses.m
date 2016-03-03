function [ ecs ] = sortEquivClasses( ecs )
    
    madeSwap = 1;
    while madeSwap
        madeSwap = 0;
        for i = 1 : numel(ecs)-1
            if compare(i, i+1) == 1
                madeSwap = 1;
                swap(i, i+1);
            end
        end
    end
    
    function swap(ind1, ind2)
        temp = ecs(ind1);
        ecs(ind1) = ecs(ind2);
        ecs(ind2) = temp;
    end

    function [ result ] = compare (ind1, ind2)
        m1 = sort(cell2mat(ecs(ind1)));
        m2 = sort(cell2mat(ecs(ind2)));
        if (m1(1) > m2(1))
            result = 1;
        elseif (m1(1) < m2(1))
            result = -1;
        else
            result = 0;
        end
    end
end

