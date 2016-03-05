classdef RandomSymmetricalGraphGenerator
    
    properties
        ssgg;
        scg;
        pBothSymmetric;
        pRHSSymmetric;
        pLHSSymmetric;
        pSmallGraphs;
        requireConnected
    end
    
    methods
        function [ obj ] = RandomSymmetricalGraphGenerator(p)
            obj.ssgg = SymmetricSmallGraphGenerator(p);
            obj.scg = SymmetricConnectionGenerator(p);
            obj.pBothSymmetric = .8;
            obj.pRHSSymmetric = .1;
            obj.pLHSSymmetric = .1;
            obj.pSmallGraphs = [.1, .30, .20, .40];
            obj.requireConnected = 0;
        end
        
        function [ obj ] = setSymmetryProbabilities(obj, pBoth, pRHS, pLHS)
            obj.pBothSymmetric = pBoth;
            obj.pRHSSymmetric = pRHS;
            obj.pLHSSymmetric = pLHS;
        end
        
        function [ index ] = getProbabilityDistValue(~, dist)
            lower = 0;
            index = 1;
            result = rand();
            while result > lower + dist(index)
                lower = lower + dist(index);
                index = index + 1;
            end
        end
        
        function [ conns ] = decideSymmetricRandomConnections(obj, d1, d2)
            if d1 == 1 || d2 == 1
                conns = obj.scg.getBothSymmetricRandomConnections(d1, d2);
            else
                r = rand();
                if r < obj.pBothSymmetric
                    conns = obj.scg.getBothSymmetricRandomConnections(d1, d2);
                elseif r < obj.pBothSymmetric + obj.pRHSSymmetric
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
                    proposedNewNumberOfVertices = obj.getProbabilityDistValue(obj.pSmallGraphs);
                end
                nVerticesSoFar = nVerticesSoFar + proposedNewNumberOfVertices;
                allSmallGraphs = horzcat(allSmallGraphs, {obj.ssgg.generate(proposedNewNumberOfVertices)});
            end

            A = zeros(n, n);

            nGraphs = numel(allSmallGraphs);
            x = 0;
            connectedTo1 = zeros(1, nGraphs);
            connectedTo1(1) = 1;
            for i = 1 : nGraphs
                d1 = size(cell2mat(allSmallGraphs(i)), 1);
                xRange = x+1 : x+d1;
                A(xRange, xRange) = cell2mat(allSmallGraphs(i));
                y = x + d1;
                for j = i+1 : nGraphs
                    d2 = size(cell2mat(allSmallGraphs(j)), 1);
                    yRange = y+1 : y+d2;
                    conns = obj.decideSymmetricRandomConnections(d1, d2);
                    if sum(sum(conns)) > 0
                        connectedTo1(i) = connectedTo1(i) || connectedTo1(j);
                        connectedTo1(j) = connectedTo1(i) || connectedTo1(j);
                    end
                    A(xRange, yRange) = conns;
                    A(yRange, xRange) = conns';
                    y = y + d2;
                end
                x = x + d1;
            end
            
            if (obj.requireConnected == 1 && ~all(connectedTo1))
                A = obj.generate(n);
            end
        end
    end
end

