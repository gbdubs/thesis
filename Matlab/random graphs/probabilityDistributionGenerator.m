classdef probabilityDistributionGenerator
    % Generates Probability Distributions for Comparisons.
    %  -> Erdos Renyi (All edges with equal probability)
    %  -> Random Matrix (Exact, calculated off of all matrices)
    %  -> Idealized (Equal Representation for Graph Objects)
    
    properties
        bins
        overall
    end
    
    methods
        function obj = probabilityDistributionGenerator(maxSupported)
            obj.bins = cell(maxSupported, 1);
            obj.overall = containers.Map('KeyType','char','ValueType','int32');
            for v = 1 : maxSupported
                allGraphs = cell((v * (v-1)) / 2 + 1,1);
                for i = 1 : size(allGraphs,1)
                    allGraphs(i) = {[]};
                end
                load(['data/numwaystowrite/',num2str(v),'.mat']);
                map = eval(['map',num2str(v)]);
                graphs = map.keys;
                for j = 1 : size(graphs, 2)
                    s = cell2mat(graphs(j));
                    A = graph6(s);
                    e = sum(sum(A))/2;
                    allGraphs(e+1) = {vertcat(cell2mat(allGraphs(e+1)), s)};
                    obj.overall(s) = map(s);
                end
                obj.bins(v) = {allGraphs};
            end
        end
        
        function [ result ] = getNumberOfDistinctMatrices(obj, s)
            s = graph6Encode(cannonicalV2(graph6(s)));
            result = double(obj.overall(s));
        end
        
        function [ set ] = getSet(obj, v, e)
            temp1 = obj.bins(v);
            temp2 = [temp1{:}];
            set = cell2mat(temp2(e+1));
        end
        
        function [ probabilityDist ] = getPDNumberOfMatrices(obj, v, e)
            set = obj.getSet(v, e);
            probabilityDist = containers.Map('KeyType','char','ValueType','double');
            total = 0;
            for i = 1 : size(set, 1)
                s = set(i,:);
                nways = obj.getNumberOfDistinctMatrices(s);
                probabilityDist(s) = double(nways);
                total = total + nways;
            end
            for i = 1 : size(set, 1)
                s = set(i,:);
                probabilityDist(s) = probabilityDist(s) / total;                
            end
        end
        
        function [ probabilityDist ] = getPDIdeal(obj, v, e)
            set = obj.getSet(v, e);
            probabilityDist = containers.Map('KeyType','char','ValueType','double');
            for i = 1 : size(set, 1)
                s = set(i,:);
                probabilityDist(s) = 1 / double(size(set, 1));
            end
        end
        
        function [ probabilityDist ] = getPDErdosRenyi(~, v, e, n)
            probabilityDist = generateErdosRenyi(v, e, n);
        end
    end
end

