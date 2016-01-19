addpath(genpath('.'));
disp 'Added all subdirectories of this directory to the path.';
copathsData;
disp 'Loaded data for the v=10 co-paths graphs.';
automorphData;
disp 'Loaded data for the automorphism vertex group failure cases.';
for i = 1 : 8
    loadData(i);
    disp(['Loaded data for all graphs with v = ', i, '.']);
end
clear i;
clear ans;