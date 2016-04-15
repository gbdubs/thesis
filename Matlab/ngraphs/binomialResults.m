
binomialN = 5 : 11;

eMax = .5 * binomialN .* (binomialN-1);

sigmaExpected = .5 * sqrt(eMax);

normSigmaExpected = sigmaExpected ./ eMax;
