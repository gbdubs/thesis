cp = v10CoPaths;

nGraphs10 = 12005168;

% Ideally
pOfCoPathsIdeal = size(cp, 1) / nGraphs10;

% In Standard Random Graph Model
nRepresentations = 0;
for i = 1 : size(cp, 1);
    A = graph6(cp(i,:));
    nAut = findNumberOfAutomorphisms(A);
    nReps = factorial(10) / nAut;
    nRepresentations = nRepresentations + nReps;
end

nMatrices = 2 ^ (10 * 9 / 2);

pOfCoPathsStandard = nRepresentations / nMatrices;

percentDifference = (pOfCoPathsStandard - pOfCoPathsIdeal) / pOfCoPathsIdeal;