function estimateTimeRemaining( startTime, nDone, nTotal )
    
    function [ explanation ] = explainTime(secs)
        if (secs > 60)
            mins = floor(secs / 60);
            secs = mod(secs, 60);
            if (mins > 60)
                hrs = floor(mins / 60);
                mins = mod(mins, 60);
                if (hrs > 24)
                    days = floor(hrs / 24);
                    hrs = mod(days, 24);
                    explanation = [num2str(days),' days, ',num2str(hrs),' hours, ',num2str(mins),' minutes, and ',num2str(secs),' seconds'];
                else
                     explanation = [num2str(hrs),' hours, ',num2str(mins),' minutes, and ',num2str(secs),' seconds'];
                end
            else
                explanation = [num2str(mins),' minutes, and ',num2str(secs),' seconds'];
            end
        else 
            explanation = [num2str(secs),' seconds'];
        end
    end
    
    elapsed = cputime - startTime;
    nRemaining = nTotal - nDone;
    estimateCpuRemaining = nRemaining * (elapsed) / nDone;
    secsRemaining = ceil(estimateCpuRemaining);
    
    pointOfCompletion = datetime('now');
    pointOfCompletion.Second = pointOfCompletion.Second + estimateCpuRemaining;
    
    disp(['Completed ',num2str(nDone),' of ',num2str(nTotal),'.']);
    disp(['Running for ', explainTime(ceil(elapsed)),'.']);
    disp(['Estimated Time Remaining ', explainTime(secsRemaining),'.']);
    disp(['Estimated Time of Completion: ', datestr(pointOfCompletion)]);
    disp(' ');
end

