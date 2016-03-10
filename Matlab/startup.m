clear all;

addpath(genpath('.'));
disp 'Added all subdirectories of this directory to the path.';

copathsData;
disp 'Loaded data for the v=10 co-paths graphs.';

load('cannonical/data/graphsEightAndSmaller.mat');
disp 'Loaded all cannonical representations of graphs of degree 8 and smaller.';

clear i;

clear('ans');