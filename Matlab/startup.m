addpath(genpath('.'));
disp 'Added all current subdirectories to path.';
copathsData;
disp 'Loaded data for the v=10 co-paths graphs.';
for i = 1 : 8
    loadData(i);
end
disp 'Loaded data for all graphs v in [1,8].';
clear i;
clear ans;