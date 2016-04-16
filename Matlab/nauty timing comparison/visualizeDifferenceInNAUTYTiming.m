IdealData = tdfread('nauty timing comparison/processedResultsIdeal.txt');
idealX = IdealData.x1;
idealY = IdealData.x00x2E50;

idealN = (1 : 99)/100;
idealMeans = zeros(1, 99);
idealSigmas = zeros(1, 99);

for i = 1 : 99
    sample = idealY(idealX == i);
    idealMeans(i) = mean(sample);
    idealSigmas(i) = std(sample);
end
hold on;
shadedErrorBar(idealN, idealMeans, idealSigmas*2,{'-bl','markerfacecolor',[1,0.2,0.2]} );

StandardData = tdfread('nauty timing comparison/processedResultsStandard.txt');
standardX = StandardData.x1;
standardY = StandardData.x00x2E49;

standardN = (1 : 99)/100;
standardMeans = zeros(1, 99);
standardSigmas = zeros(1, 99);

for i = 1 : 99
    sample = standardY(standardX == i);
    standardMeans(i) = mean(sample);
    standardSigmas(i) = std(sample);
end

shadedErrorBar(standardN, standardMeans, standardSigmas*2,{'-or','markerfacecolor',[1,0.2,0.2]} );

sum((idealMeans - standardMeans)/100)

hold off;

