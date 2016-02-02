function [ allEncodings ] = generateAllValidPermutationsOfEncoding( encoding )

    A = graph6(encoding);
    qec = findQuaziEquivalenceClasses(A);
    perms = generateAllPermutations(qec);

    allEncodings = char(zeros(size(perms, 2), size(encoding, 2)));
    for i = 1 : size(perms, 2)
        B = generatePermMatrixFromVector(perms(:, i));
        C = B' * A * B;
        allEncodings(i,:) = graph6Encode(C);
    end

end

