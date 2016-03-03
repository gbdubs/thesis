classdef RandomSymmetricalGraphGenerator
    
    properties
        ssgg;
        scg;
    end
    
    methods
        function [ obj ] = RandomSymmetricalGraphGenerator(p)
            obj.ssgg = SymmetricSmallGraphGenerator(p);
            obj.scg = SymmetricConnectionGenerator(p);
        end
        
        function [ conns ] = decideSymmetricRandomConnections(obj, d1, d2)
            if d1 == 1 || d2 == 1
                conns = obj.scg.getBothSymmetricRandomConnections(d1, d2);
            else
                if rand() < .8
                    conns = obj.scg.getBothSymmetricRandomConnections(d1, d2);
                elseif rand() < .5
                    conns = obj.scg.getRightSymmetricRandomConnections(d1, d2);
                else
                    conns = obj.scg.getLeftSymmetricRandomConnections(d1, d2);
                end
            end
        end
        
        function [ A ] = generate(obj, n)
            allSmallGraphs = {};
            nVerticesSoFar = 0;
            while nVerticesSoFar < n
                proposedNewNumberOfVertices = n+1;
                while nVerticesSoFar + proposedNewNumberOfVertices > n
                    proposedNewNumberOfVertices = ceil(rand() * 4);
                end
                nVerticesSoFar = nVerticesSoFar + proposedNewNumberOfVertices;
                allSmallGraphs = horzcat(allSmallGraphs, {obj.ssgg.generate(proposedNewNumberOfVertices)});
            end

            A = zeros(n, n);

            nGraphs = numel(allSmallGraphs);
            x = 0;
            for i = 1 : nGraphs
                d1 = size(cell2mat(allSmallGraphs(i)), 1);
                xRange = x+1 : x+d1;
                A(xRange, xRange) = cell2mat(allSmallGraphs(i));
                y = x + d1;
                for j = i+1 : nGraphs
                    d2 = size(cell2mat(allSmallGraphs(j)), 1);
                    yRange = y+1 : y+d2;
                    conns = obj.decideSymmetricRandomConnections(d1, d2);
                    
                    A(xRange, yRange) = conns;
                    A(yRange, xRange) = conns';
                    y = y + d2;
                end
                x = x + d1;
            end
        
        end
        
    end
end

