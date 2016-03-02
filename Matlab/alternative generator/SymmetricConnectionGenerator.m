classdef SymmetricConnectionGenerator
    
    properties
        rhsSC
        lhsSC
        bothSC
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
    end
    
    methods
        function [ obj ] = SymmetricConnectionGenerator
            load 'alternative generator/bipartiteSymmetricalConnectionData.mat'
            obj.rhsSC = rhsSymmetricConnections;
            obj.lhsSC = lhsSymmetricConnections;
            obj.bothSC = bothSymmetricConnections;
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

