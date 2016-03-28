RAW_Contingent = {'CANNON'};

CANNON_Contingent = {'ADSM';'DSMV';'ADSMD';'DSMDV';'ADSMN';'DSMNV';'ADSMX';'DSMXV';'ADSV';'DSVV';'ADSR';'PQRA';'PQRB';'PQRC';'ODSPL';'NA';'NAC';'NAB';'ANA';'NCP';'CP';'NR';'NE';'PCONN';'ANCC';'NCCV';'ADIAM';'DIAMV';'PTRIL';'ANTRI';'ANQUAD';'UG';'FC';'FFV';'FFC'};

NA_Contingent = {'ALNA';'MLNA';'VLNA'};

FC_Contingent = {'NUG';'ANR';'MNR';'SQNR';'PDL'};



fromVariables = {'RAW'; 'CANNON'; 'NA'; 'FC'};
contingentVariables = {RAW_Contingent, CANNON_Contingent, NA_Contingent, FC_Contingent};

for j = 1 : numel(fromVariables)
    fromVariable = fromVariables{j};
    contingentVars = contingentVariables{j};
    for i = 1 : numel(contingentVars)
        toVariable = cell2mat(contingentVars(i));
        disp(['Beginning Abstract Processing of [',fromVariable,'] --> [',toVariable,']']);
        abstractProcessRandomGraphData(fromVariable, toVariable);
    end
end



clear('RAW_Contingent', 'CANNON_Contingent', 'NA_Contingent','FC_Contingent','fromVariables','contingentVariables','j','i','fromVariable','contingentVars','toVariable');