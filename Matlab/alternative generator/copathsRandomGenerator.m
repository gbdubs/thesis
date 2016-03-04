classdef copathsRandomGenerator

    properties
        RSGG
        p2G1E
        p2G2E
        p1G1E
    end
    
    methods
        function [ obj ] = copathsRandomGenerator( p )
            obj.RSGG = RandomSymmetricalGraphGenerator( p );
            obj.RSGG.requireConnected = 1;
            obj.RSGG.setSymmetryProbabilities(1.0, 0, 0);
            obj.p1G1E = 1;
            obj.p2G1E = 0;
            obj.p2G2E = 0;
        end
        
        function [ A ] = augmentSwitch(obj, G, qecs)
            r = rand();
            if r < obj.p1G1E
                A = obj.augmentWithInGroupEdge(G, qecs);
            elseif r < obj.p1G1E + obj.p2G1E
                A = obj.augmentWithBetweenGroupsOneEdge(G, qecs);
            elseif r < obj.p1G1E + obj.p2G1E + obj.p2G2E
                A = obj.augmentWithBetweenGroupsTwoEdges(G, qecs);
            end
        end
        
        function [ resultSet ] = generate (obj, n, nAttempts )
            G = obj.RSGG.generate(n);
            nchars = size(graph6Encode(G),2);
            while ~all(sum(G) > 0)
                G = obj.RSGG.generate(n);
            end
            qecs = findQuaziEquivalenceClasses(G);
            
            resultSet = char(zeros(nAttempts, nchars));
            
            for i = 1 : nAttempts
                resultSet(i,:) = graph6Encode(obj.augmentSwitch(G, qecs));
            end
        end
    end
    
    methods(Static)
        
        function [ A ] = augmentWithInGroupEdge(G, qecs)
            A = G;
            group1 = copathsRandomGenerator.getRandTwoPlusGroupFromQECs(qecs, []);
            if (group1 ~= -1)
                edge = copathsRandomGenerator.generateRandomSomeEdgesFromGroups(cell2mat(qecs(group1)), cell2mat(qecs(group1)), 1);
                A = augmentGraphWithEdges(G, edge);
            end
        end
        
        function [ A ] = augmentWithBetweenGroupsOneEdge(G, qecs)
            A = G;
            group1 = copathsRandomGenerator.getRandTwoPlusGroupFromQECs(qecs, []);
            if (group1 ~= -1)
            group2 = copathsRandomGenerator.getRandTwoPlusGroupFromQECs(qecs, group1);
                if (group2 ~= -1)
                    edge = copathsRandomGenerator.generateRandomSomeEdgesFromGroups(cell2mat(qecs(group1)), cell2mat(qecs(group2)), 1);
                    A = augmentGraphWithEdges(G, edge);
                end
            end
        end
        
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
                g2 = group2(ceil(numel(group1) * rand()));
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

