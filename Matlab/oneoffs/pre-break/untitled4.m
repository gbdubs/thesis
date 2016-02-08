targetSet = v10e22;
errorCases = [];

for i = 1 : size(targetSet, 1);
    tempRes = verifyPathsDefinesAutomorphismGroups(graph6(targetSet(i,:)), false);
    if (tempRes ~= 1)
        disp(['ERROR', targetSet(i,:)]);
        errorCases = horzcat(errorCases, i);
    end
end

errorCases


% v10e20 (15) ICR`uiwY_
% v10e21 (7)  ICR`vGy}?
% v10e22 (15) ICpdbj[N_
% v10e22 (16) ICXedrMn?
