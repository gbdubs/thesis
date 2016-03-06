function convertToCannonical(FOLDER_NAME, VARIABLE_NAME)
    % Makes all of the data in the input folder cannonical.
    files = dir(FOLDER_NAME)';
    for file = files
        if ~file.isdir
            index = strfind(file.name, 'CANNON_');
            if numel(index) == 0
                newFileName = [FOLDER_NAME, '/CANNON_', file.name];
                if ~exist(newFileName, 'file')
                    load([FOLDER_NAME,'/',file.name]);
                    if exist(VARIABLE_NAME, 'var')
                        disp(['CONVERTING FILE ', file.name]);
                        v = eval(VARIABLE_NAME);
                        temp = char(zeros(size(v)));
                        n = size(v, 1);
                        progressbar;
                        for i = 1 : n
                            progressbar(i / n);
                            temp(i,:) = graph6Encode(cannonical(graph6(v(i,:))));
                        end
                        eval([VARIABLE_NAME,' = temp;']);
                        save(newFileName, VARIABLE_NAME);
                    end
                end
            end
        end
    end
end
