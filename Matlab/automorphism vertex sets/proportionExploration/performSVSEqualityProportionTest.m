function [ proportionEqual ] = performSVSEqualityProportionTest( N, P, nTrials )

    successes = 0;
    failures = 0;

    progressbar;
    for trial = 1 : nTrials
        if (mod(trial, 50) == 0)
            progressbar(trial / nTrials);
        end
        % Generates a random graph (Gilbert Style)
        k = 1 - sqrt(P);
        r = rand(N, N);
        t = (r > k) & (ones(N, N) - eye(N, N));
        A = t & t';

        % Sees if the SVSes == Cycles QSVSes.
        result = verifyPathsDefinesAutomorphismGroups(A, 0);

        if result < 0
            failures = failures + 1;
            disp('FAILURE');
            disp(failures / (failures + successes));
        elseif result > 0
            successes = successes + 1;
        end

    end
    
    proportionEqual = successes / (failures + successes);
end

