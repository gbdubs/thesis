function considerTimeEstimation(t, i, n, nUpdates, message)
    if (mod(i * nUpdates, n) < mod((i-1) * nUpdates, n))
        estimateTimeRemaining(t, i, n, message); 
    end
end

