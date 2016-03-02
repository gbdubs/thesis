classdef SymmetricSmallGraphGenerator
    
    properties
    end
    
    methods
        function [ A ] = generate(~, n)
            if n == 1
                A = zeros(1);
            elseif n == 2
                if rand() > .5
                    A = [0 0; 0 0];
                else
                    A = [0 1; 1 0];
                end
            elseif n == 3
                if rand() > .5
                    A = [0 0 0; 0 0 0; 0 0 0];
                else
                    A = [0 1 1; 1 0 1; 1 1 0];
                end
            elseif n == 4
                if rand() < .25
                    A = [0 0 0 0; 0 0 0 0; 0 0 0 0; 0 0 0 0];
                elseif rand() < 1/3
                    A = [0 1 0 0; 1 0 0 0; 0 0 0 1; 0 0 1 0];
                elseif rand() < 1/2
                    A = [0 0 1 1; 0 0 1 1; 1 1 0 0; 1 1 0 0];
                else
                    A = [0 1 1 1; 1 0 1 1; 1 1 0 1; 1 1 1 0];
                end
            end
            
            perm = randperm(n);
            A = A(perm, perm);
        end
    end
end

