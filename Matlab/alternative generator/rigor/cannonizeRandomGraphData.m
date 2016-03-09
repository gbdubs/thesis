function cannonizeRandomGraphData ()
    
    function [ isEqual ] = equalCellRows(cr1, cr2)
        isEqual = 1;
        for index = 1 : numel(cr1)
            if cell2mat(cr1(index)) ~= cell2mat(cr2(index))
                isEqual = 0;
                return;
            end
        end
    end

    allRaw = getListOfRandomGraphFileNames(0);
    allCannon = getListOfRandomGraphFileNames(1);
    
    for i = 1 : size(allRaw, 1)
        if i > size(allCannon, 1) || ~(equalCellRows(allRaw(i,:), allCannon(i,:)))
            n = cell2mat(allRaw(i,1));
            p = cell2mat(allRaw(i,2));
            alg = cell2mat(allRaw(i,3));
            nGraphs = cell2mat(allRaw(i,4));

            inputPath = pathToRandomGraphData(n, p, alg, nGraphs, 0, 0);
            disp(['Beginning Cannonization of ', inputPath]);
            outputPath = pathToRandomGraphData(n, p, alg, nGraphs, 1, 1);
            
            load(inputPath);
            
            graphSet = convertDataToCannonical(graphSet);
            
            save(outputPath, 'graphSet');
            
            cannonizeRandomGraphData();
            
            return;
        end 
    end
end

