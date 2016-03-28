restoredefaultpath;
clear all;

load('data/cannonicalMemoization.mat');
global cannonicalMemoization;

disp('Loaded cannonicalMemoziation Data.');
global allMetricMapping;
allMetricMapping = containers.Map;

global nAutomorphismMemoization;
disp('Loading NAutomorphismMemoization');
load('data/nAutomorphismMemoization');

for file = dir('.')'
    if file.isdir
        if ~strcmp(file.name,'alternative generator') && numel(file.name) > 2
            disp(['    loading ', file.name]);
            addpath(genpath(file.name));
        end
    end
end

addpath('alternative generator');
for file = dir('alternative generator')';
    if file.isdir
        if ~strcmp(file.name,'smalldata') && numel(file.name) > 2
            disp(['    loading ', file.name]);
            addpath(genpath(['alternative generator','/',file.name]));
        end
    end
end

disp 'Added all subdirectories of this directory to the path, except for the alternative generator data.';

copathsData;
disp 'Loaded data for the v=10 co-paths graphs.';

load('cannonical/data/graphsEightAndSmaller.mat');
disp 'Loaded all cannonical representations of graphs of degree 8 and smaller.';

clear i file;

clear('ans');