function [ output_args ] = findMaximalPathsDifferentiatingPower( A, maxPower )
    v = size(A, 2);

    B = A;
    
    eClasses = {1:v};
    
    currentPower = 2;
    lastDifferentiatingPower = 0;
    
    while (currentPower <= maxPower && size(eClasses, 2) < v)
        B = B * A;
        if (any(any(B >= flintmax)))
            output_args = lastDifferentiatingPower;
            return;
        end
        
        e = 1;
        while (e <= size(eClasses, 2))
            eClass = cell2mat(eClasses(e));
            same = [eClass(1)];
            diff = [];
            val = B(eClass(1), eClass(1));
            for i = 2 : size(eClass, 2)
                if (B(eClass(i), eClass(i)) == val)
                    same = horzcat(same, eClass(i));
                else
                    diff = horzcat(diff, eClass(i));
                end
            end
            if (size(diff, 2) > 0)
                eClasses(e) = {same};
                eClasses = horzcat(eClasses, {diff});
                lastDifferentiatingPower = currentPower;
            end
            e = e + 1;
        end
        currentPower = currentPower + 1;
    end
    
    output_args = lastDifferentiatingPower;
end

