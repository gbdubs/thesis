

function ProcessAllData(FOLDER_NAME)
    % Converts the unconverted data to cannonical data.
    convertToCannonical(FOLDER_NAME, 'graphSet');
    % PROCESS ALL DATA
    files = dir(FOLDER_NAME)';
    for file = files
        if ~file.isdir
            if strfind(file.name, 'CANNON_')
                load([FOLDER_NAME,'/',file.name]);
                processDataSet(P, ALG, SIZE);
            end
        elseif ~strcmp(file.name, '.') && ~strcmp(file.name, '..')
            ProcessAllData([FOLDER_NAME,'/',file.name]);
        end
    end
end


