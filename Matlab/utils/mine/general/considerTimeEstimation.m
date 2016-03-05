function considerTimeEstimation(t, i, n, nUpdates, message)
    if (mod(i * nUpdates, n) < mod((i-1) * nUpdates, n))
        if (nargin < 5)
            message = '';
        end    
        estimateTimeRemaining(t, i, n, message); 
    end
end

