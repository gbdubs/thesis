numGraphs = [1, 1, 2, 4, 11, 34, 156, 1044, 12346, 274668, 12005168, 1018997864, 165091172592, 50502031367952, 29054155657235488, 31426485969804308768, 64001015704527557894928, 245935864153532932683719776, 1787577725145611700547878190848, 24637809253125004524383007491432768];
temp = (0 : (size(numGraphs, 2) -1));
numMats = 2 .^ ((temp .* temp - temp)/2);

matrixRepresentationsPerGraph = numMats ./ numGraphs;
maxRepresentationsPerGraph = factorial(temp);

proportionOfPotential = matrixRepresentationsPerGraph ./ maxRepresentationsPerGraph

clear temp;