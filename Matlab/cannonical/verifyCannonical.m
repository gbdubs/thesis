function [ successful ] = verifyCannonical( A, nTrials )
    successful = 1;
    [cannon, perm] = cannonicalV1(A);

    for trial = 1 : nTrials
        p = randperm(size(A, 1));
        B = generatePermMatrixFromVector(p');
        C = B' * A * B;
        [cannon2, perm2] = cannonicalV1(C);
        if isequal(cannon, cannon2)
            % D = generatePermMatrixFromVector(perm2');
            % THIS IS BROKEN. FIX IT.
            if isequal(cannon2, C(perm2, perm2))
                if (mod(trial, 10) == 0)
                    disp(['Trial ',num2str(trial),' was successful.']);
                end
            else
                successful = 0;
                disp(['PERMUTATION NOT WORKING for "', ...
                    graph6Encode(A),'" and "',graph6Encode(C),'" !!! ']);
                return;
            end
        else
            successful = 0;
            disp(['CANNONS NOT EQUAL for "', ...
                graph6Encode(A),'" and "',graph6Encode(C),'" !!! ']);
            return;
        end
    end
end

