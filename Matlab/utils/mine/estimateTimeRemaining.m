function estimateTimeRemaining( startTime, nDone, nTotal )
    disp (['Completed ',num2str(nDone),' of ',num2str(nTotal),'.']);
    
    elapsed = cputime - startTime;
    nRemaining = nTotal - nDone;
    estimateCpuRemaining = nRemaining * (elapsed) / nDone;
    disp(['Estimated CPU Time Remaining ',num2str(ceil(estimateCpuRemaining)),' seconds.']);
    
    currentTime = datetime('now');
    currentTime.Second = currentTime.Second + estimateCpuRemaining;
    
    disp('Estimated Time of Completion:');
    disp(currentTime);
end

