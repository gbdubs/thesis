function [ rhsSymmetricConnections, lhsSymmetricConnections, bothSymmetricConnections  ] = forcefullyCalculateBipartiteSymmetricConnections( maxV )
    
    bothSymmetricConnections = cell(maxV, maxV);
    lhsSymmetricConnections = cell(maxV, maxV);
    rhsSymmetricConnections = cell(maxV, maxV);
    
    function [ c ] = generateConns(d1, d2, seed)
        z = zeros(1, d1 * d2);
        t = uint32(dec2bin(seed)) - 48;
        z(d1*d2 - size(t, 2) + 1:end) = t;
        c = reshape(z, d1, d2); 
    end
    
    for i = 1 : maxV
        for j = 1 : maxV
            disp(['========== i ', num2str(i), ' j ', num2str(j),' ===========']);
            started = cputime;
            
            RHSSymmetricConnections = {};
            LHSSymmetricConnections = {};
            SymmetricConnections = {};

            maxest = 2^(i*j);

            for seed = 0 : maxest - 1
                if cputime - started > 1
                    considerTimeEstimation(started, seed, maxest-1, 10);
                end
                
                conns = generateConns(i, j, seed);
                rhs = testForRHSAutomorphisms(conns);
                lhs = testForLHSAutomorphisms(conns);
                if (rhs && lhs)
                    SymmetricConnections = horzcat(SymmetricConnections, {conns});
                elseif (rhs)
                    RHSSymmetricConnections = horzcat(RHSSymmetricConnections, {conns});
                elseif (lhs)
                    LHSSymmetricConnections = horzcat(LHSSymmetricConnections, {conns});
                end
            end

            rhsAsMat = zeros(numel(RHSSymmetricConnections), i, j);
            for k = 1 : size(RHSSymmetricConnections, 2)
                rhsAsMat(k, :, :) = cell2mat(RHSSymmetricConnections(k));
            end
            
            lhsAsMat = zeros(numel(LHSSymmetricConnections), i, j);
            for k = 1 : size(LHSSymmetricConnections, 2)
                lhsAsMat(k, :, :) = cell2mat(LHSSymmetricConnections(k));
            end
            
            bothAsMat = zeros(numel(SymmetricConnections), i, j);
            for k = 1 : size(SymmetricConnections, 2)
                bothAsMat(k, :, :) = cell2mat(SymmetricConnections(k));
            end
            
            rhsSymmetricConnections(i, j) = {rhsAsMat};
            lhsSymmetricConnections(i, j) = {lhsAsMat};
            bothSymmetricConnections(i, j) = {bothAsMat};
        end
    end
end

