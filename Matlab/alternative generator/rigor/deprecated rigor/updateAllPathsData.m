function updateAllPathsData()
    allPaths = strsplit(genpath('alternative generator/data'),':')';
    save('alternative generator/data/allPaths.mat', 'allPaths');
end

