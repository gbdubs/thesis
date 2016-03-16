close all;

minV = 4;
maxV = 10;


metrics = [
%     {'NCP'}
%     {'MLNA'}
%     {'ALNA'}
%     {'VLNA'}
%     {'ADSM'}
%     {'DSMV'}
%     {'ADSMD'}
%     {'DSMDV'}
%     {'ADSMN'}
%     {'DSMNV'}
%     {'ADSMX'}
%     {'DSMXV'}
%     {'ADSV'}
%     {'DSVV'}
%     {'ADSR'}
%     {'PQRA'}
     {'ANCC'}
%     {'PQRB'}
%     {'PQRC'}
%     {'ODSPL'}
%     {'NCP'}
%     {'NUG'}
%     {'ANR'}
%     {'MNR'}
%     {'SQNR'}
%     {'ANCC'}
%     {'NCCV'}
%     {'PTRIL'}
     {'ANTRI'}
     {'ANQUAD'}
     {'SQNR'}
]';

doLog = 1;

for metric = metrics
    metricName = cell2mat(metric);
    for v = minV : maxV
        generateComparisonAccrossP(v, metricName, doLog)
        print(['alternative generator/analysis/auto output/',metricName,'-',num2str(v)],'-dpng');
        close all;
    end
end