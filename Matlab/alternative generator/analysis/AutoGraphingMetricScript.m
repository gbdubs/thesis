close all;

minV = 4;
maxV = 10;

metric = 'PDL';

doLog = 0;

for v = minV : maxV
    generateComparisonAccrossP(v, metric, doLog)
    print(['alternative generator/analysis/auto output/',metric,'-',num2str(v)],'-dpng');
    close all;
end