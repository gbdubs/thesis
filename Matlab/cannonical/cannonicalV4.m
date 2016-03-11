function [ B , finalPerm ] = cannonicalV4( A )
    % Catch cases where A is empty or full 

    t = cputime;
    
    N = size(A, 1);
    nEdges = sum(sum(A)) / 2;
    if nEdges == 0 || nEdges == (N*(N-1)/2)
        B = A;
        finalPerm = 1:N;
        return;
    end
    
    % Catch cases where we have fully disconnected or fully connected nodes
    % (note we can only have one, we don't need to think about having
    % both)
    
    degrees = sum(A);
    full = find(degrees == N-1);
    empty = find(degrees == 0);
    allBut = setdiff(setdiff(1 : N, full), empty);
    if numel(allBut) ~= N
        C = A(allBut, allBut);
        C = cannonical(C);
        smallN = size(C, 1);
        if numel(full) > 0
            B = ones(N, N) - eye(N, N);
        else
            B = zeros(N, N); 
        end
        B(1:smallN, 1:smallN) = C;
        return;
    end
    
    
    try
        qecp = findQuaziEquivalenceClassesPlus(A);

        qecp = cannonicalSortQECs(A, qecp);

        allPerms = cell(size(qecp));
        for i = 1 : size(qecp, 2)
            idx = cell2mat(qecp(i));
            allPerms(i) = {cannonicalGenerateAllMaximalPerms(A, idx)};
        end

        ps = cell2mat(allPerms(1));
        ps = cannonicalTrimPerms(A, ps);
        for i = 2 : size(allPerms, 2)
            ps = cannonicalCombinePermutations(ps, cell2mat(allPerms(i)));
            ps = cannonicalTrimPerms(A, ps, 1000);
        end

        finalPerm = ps(1,:);
        B = A(finalPerm, finalPerm);
    catch
        warning(['CV4 Failed: ', graph6Encode(A)]);
        B = -1;
        finalPerm = -1;
    end
    
    if cputime - t > 10
        disp(graph6Encode(A));
    end
    
end