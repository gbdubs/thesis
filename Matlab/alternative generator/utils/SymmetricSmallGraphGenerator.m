classdef SymmetricSmallGraphGenerator
    
    properties
        pTarget;
        weights2;
        weights3;
        weights4;
        values2;
        values3;
        values4;
    end
    
    methods
        function [ obj ] = SymmetricSmallGraphGenerator(p)
            
            obj.values2 = cell(2, 1);
            obj.values2(1) = {[0 0; 0 0]};
            obj.values2(2) = {[0 1; 1 0]};
            
            obj.values3 = cell(2, 1);
            obj.values3(1) = {[0 0 0; 0 0 0; 0 0 0]};
            obj.values3(2) = {[0 1 1; 1 0 1; 1 1 0]};
            
            obj.values4 = cell(4, 1);
            obj.values4(1) = {[0 0 0 0; 0 0 0 0; 0 0 0 0; 0 0 0 0]};
            obj.values4(2) = {[0 1 0 0; 1 0 0 0; 0 0 0 1; 0 0 1 0]};
            obj.values4(3) = {[0 0 1 1; 0 0 1 1; 1 1 0 0; 1 1 0 0]};
            obj.values4(4) = {[0 1 1 1; 1 0 1 1; 1 1 0 1; 1 1 1 0]};
            
            if 0 <= p && p <= 1
                obj.pTarget = p;
                obj.weights2 = [1 - p, p];
                obj.weights3 = [1 - p, p];
                % BOSS!!! Projection onto a 4D Plane through minimization,
                % fools!
                obj.weights4 = [(4 - 5*p)/ 6, (5 - 4*p)/12, (1 + p)/6, (4*p - 1) / 4];
                obj.weights4 = max(obj.weights4, 0);
                obj.weights4 = (1 / sum(obj.weights4)) * obj.weights4;
            end
        end
        
        function [ A ] = generate(obj, n)
            if n == 1
                A = zeros(1);
            elseif n == 2
                A = cell2mat(obj.values2(obj.getProbabilityDistValue(obj.weights2)));
            elseif n == 3
                A = cell2mat(obj.values3(obj.getProbabilityDistValue(obj.weights3)));
            elseif n == 4
                A = cell2mat(obj.values4(obj.getProbabilityDistValue(obj.weights4)));
            end
            perm = randperm(n);
            A = A(perm, perm);
        end
    end
    
    methods(Static)
        function [ index ] = getProbabilityDistValue(dist)
            lower = 0;
            index = 1;
            result = rand();
            while result > lower + dist(index)
                lower = lower + dist(index);
                index = index + 1;
            end
        end
    end
end

