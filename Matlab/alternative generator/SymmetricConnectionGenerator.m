classdef SymmetricConnectionGenerator
    
    properties
        rhsSC
        lhsSC
        bothSC
        rhsProbDist
        lhsProbDist
        bothProbDist
    end
    
    methods(Static)
        function [ conns ] = getInternal(dim1, dim2, cellMatrix)
            if dim1 > 4 || dim2 > 4 || dim1 < 1 || dim2 < 1
                conns = zeros(0);
            else
                allConns = cell2mat(cellMatrix(dim1, dim2));
                idx = ceil(rand() * size(allConns, 1));
                temp = allConns(idx, :, :);
                conns = reshape(temp, dim1, dim2);
            end
        end
        
        function [ probDist ] = getProbDist( matOfPossibilities , target )
            weights = zeros(size(matOfPossibilities, 1),1);
            for i = 1 : numel(weights)
                weights(i) = sum(sum(sum(matOfPossibilities(i,:,:))));
            end
            probDist = solveGeneralizedProbabilityDistributionTargetingProblem(weights, target);
        end
    end
    
    methods
        function [ obj ] = SymmetricConnectionGenerator(p)
            load 'alternative generator/bipartiteSymmetricalConnectionData.mat'
            obj.rhsSC = rhsSymmetricConnections;
            obj.lhsSC = lhsSymmetricConnections;
            obj.bothSC = bothSymmetricConnections;
            
            obj.rhsProbDist = cell(4, 4);
            obj.lhsProbDist = cell(4, 4);
            obj.bothProbDist = cell(4, 4);
            
            for d1 = 2 : 4
                for d2 = 2 : 4
                    obj.rhsProbDist(d1, d2) = {SymmetricConnectionGenerator.getProbDist(cell2mat(obj.rhsSC(d1, d2)), d1 * d2 * p)};
                    obj.lhsProbDist(d1, d2) = {SymmetricConnectionGenerator.getProbDist(cell2mat(obj.lhsSC(d1, d2)), d1 * d2 * p)};
                    obj.bothProbDist(d1, d2) = {SymmetricConnectionGenerator.getProbDist(cell2mat(obj.rhsSC(d1, d2)), d1 * d2 * p)};
                end
            end
        end
        
        
        function [ conns ] = getLeftSymmetricRandomConnections(obj, dim1, dim2)
            conns = getInternal(dim1, dim2, obj.lhsSC);
        end 
        
        function [ conns ] = getRightSymmetricRandomConnections(obj, dim1, dim2)
            conns = SymmetricConnectionGenerator.getInternal(dim1, dim2, obj.rhsSC);
        end 
        
        function [ conns ] = getBothSymmetricRandomConnections(obj, dim1, dim2)
            conns = getInternal(dim1, dim2, obj.bothSC);
        end 
    end
end

