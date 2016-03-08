clear all;
addpath(genpath('.'));
disp 'Added all subdirectories of this directory to the path.';
copathsData;
disp 'Loaded data for the v=10 co-paths graphs.';
% automorphData;
% disp 'Loaded data for the automorphism vertex group failure cases.';
for i = 1 : 8
    loadData(i);
    disp(['Loaded data for all graphs with v = ', num2str(i), '.']);
end
disp 'Loaded all cannonical representations of graphs of degree 8 and smaller.';
load('/Users/Grady/Desktop/Thesis/Matlab/cannonical/data/graphsEightAndSmaller.mat')
clear i;
clear('ans');