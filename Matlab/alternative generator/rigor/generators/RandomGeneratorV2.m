classdef RandomGeneratorV2
    
    properties
        RSGG
        proba
    end
    
    methods
        function [ obj ] = RandomGeneratorV2( p )
            obj.RSGG = RandomSymmetricalGraphGenerator( p );
            obj.RSGG.requireConnected = 1;
            obj.RSGG.setSymmetryProbabilities(.8, .1, .1);
            obj.proba = p;
        end
        
        function [ A ] = generate (obj, n)
            G = obj.RSGG.generate(n);
            qecs = findQuaziEquivalenceClasses(G);
            A = obj.augmentWithBetweenGroupsTwoEdges(G, qecs);
        end
        
        function [ graphSet ] = generateSet (obj, n, nGraphs, shouldSave)
            if nargin < 4
                shouldSave = 1;
            end
            
            A = obj.generate(n);
            EA = graph6Encode(A);
            
            graphSet = char(zeros(nGraphs, size(EA, 2)));
            graphSet(1,:) = EA;
            progressbar;
            for i = 2 : nGraphs
                progressbar(i / nGraphs);
                graphSet(i,:) = graph6Encode(obj.generate(n));
            end
            
            if shouldSave
                thePath = pathToRandomGraphData(n, obj.proba, 'V2', nGraphs, 0);
                save(thePath, 'graphSet');
            end
        end
    end
    
    methods(Static)
        
        function [ A ] = augmentWithBetweenGroupsTwoEdges(G, qecs)
            A = G;
            group1 = copathsRandomGenerator.getRandTwoPlusGroupFromQECs(qecs, []);
            if (group1 ~= -1)
            group2 = copathsRandomGenerator.getRandTwoPlusGroupFromQECs(qecs, group1);
                if (group2 ~= -1)
                    edge = copathsRandomGenerator.generateRandomSomeEdgesFromGroups(cell2mat(qecs(group1)), cell2mat(qecs(group2)), 2);
                    A = augmentGraphWithEdges(G, edge);
                end
            end
        end
        
        function [ groupNo ] = getRandTwoPlusGroupFromQECs(qecs, exclude)
            tries = 0;
            validIndices = setdiff(1 : numel(qecs), exclude);
            if (numel(validIndices) == 0)
                groupNo = exclude(ceil(rand() * numel(exclude)));
                return;
            end
            groupNo = validIndices(ceil(numel(validIndices) * rand()));
            while numel(cell2mat(qecs(groupNo))) == 1
                tries = tries + 1;
                if (tries >= 1000)
                    groupNo = -1;
                    return;
                end
                groupNo = validIndices(ceil(numel(validIndices) * rand()));
            end
        end
        
        function [ edges ] = generateRandomSomeEdgesFromGroups( group1, group2 , n )
            edges = zeros(n, 2);
            index = 1;
            while index <= n
                g1 = group1(ceil(numel(group1) * rand()));
                g2 = group2(ceil(numel(group2) * rand()));
                if (g1 ~= g2)
                    e1 = min(g1, g2);
                    e2 = max(g1, g2);
                    found = 0;
                    for i = 1 : index-1
                        if edges(i, 1) == e1 && edges(i, 2) == e2
                            found = 1;
                        end
                    end
                    if ~found
                        edges(index,:) = [e1, e2];
                        index = index + 1;
                    end
                end
            end
        end
    end 
end

