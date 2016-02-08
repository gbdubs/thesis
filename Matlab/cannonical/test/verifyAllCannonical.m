function [ successes ] = verifyAllCannonical( data, nTrials )
    successes = 0;
    for i = 1 : size(data, 1)
        disp(['CURRENTLY EXAMINING ',num2str(i),' of ',num2str(size(data, 1)), '.']);
        successes = successes + verifyCannonical(graph6(data(i,:)), nTrials);
    end
    disp([num2str(successes),'/',num2str(size(data,1)),' Successes.']);
end

