% CPG  = Set of Co-paths Graphs in Set of Graphs. 
% FC   = The number of each unique graph.
% FCC  = Frequency Count (how many graphs were seen 1 time, 2 times, etc.)
% FFV  = Frequency Count Values (the 1 time, 2 time part)
% GS   = Graph Set (the actual set of graphs)
% NCPG = Number of co-paths graphs within the set
% UG   = Each Unique Graph as a graph6 encoded string.

clear('graphSet');
clear('nCoPathsGraphs', 'coPathsGraphs');
clear('uniqueGraphs', 'frequencyCounts', 'ffValues', 'ffCounts');

P = .4;
ALG = 'Standard';
SIZE = '10K';

dataPath = ['alternative generator/data p=',num2str(P),'/',ALG,'/CANNON_',ALG,'-',SIZE];

load(dataPath);


GSname = ['GS_',ALG,SIZE];
if ~exist(GSname, 'var')
    eval([GSname,' = graphSet;']);
    save(dataPath, 'graphSet', GSname);
end


UGname = ['UG_',ALG,SIZE]; FCname = ['FC_',ALG,SIZE];
FFVname = ['FFV_',ALG,SIZE]; FFCname = ['FFC_',ALG,SIZE];
if ~exist(UGname, 'var')
    [ uniqueGraphs, frequencyCounts, ffValues, ffCounts ] = getHistogramCountsInCannonicalSet(graphSet);
    eval([UGname,' = uniqueGraphs;']);
    eval([FCname,' = frequencyCounts;']);
    eval([FFVname,' = ffValues;']);
    eval([FFCname,' = ffCounts;']);
    save(dataPath, 'graphSet', GSname, UGname, FCname, FFVname, FFCname);
    clear('uniqueGraphs', 'frequencyCounts', 'ffValues', 'ffCounts');
end


CPGname = ['CPG_',ALG,SIZE];NCPGname = ['NCPG_',ALG,SIZE];
if ~exist(NCPGname, 'var')
    [ nCoPathsGraphs, coPathsGraphs ] = findNumberOfCoPathsGraphsInCannonicalSet(graphSet);
    eval([CPGname,' = coPathsGraphs;']);
    eval([NCPGname,' = nCoPathsGraphs;']);
    save(dataPath, 'graphSet', GSname, UGname, FCname, FFVname, FFCname, CPGname, NCPGname);
    clear('nCoPathsGraphs', 'coPathsGraphs');
end

clear('ALG', 'P', 'SIZE', 'dataPath', 'graphSet', 'ans','CPGname', 'NCPGname', 'GSname', 'UGname', 'FFVname', 'FFCname', 'FCname');