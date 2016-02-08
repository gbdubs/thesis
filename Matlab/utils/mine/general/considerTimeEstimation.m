function considerTimeEstimation(t, i, n, nUpdates )
    if (mod(i * nUpdates, n) < mod((i-1) * nUpdates, n))
        estimateTimeRemaining(t, i, n); 
    end
end

