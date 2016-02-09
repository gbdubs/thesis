pdg = probabilityDistributionGenerator(7);
for v = 1 : 7
    for e = 0 : (v * (v-1) /2)
        n = 500 * v;
        disp(' ');
        disp(['ERDOS/IDEAL : V = ', num2str(v), ' E = ', num2str(e)]);
        ideal = pdg.getPDIdeal(v, e);
        erdos = pdg.getPDErdosRenyi(v, e, n);
        compareProbabilityDistribution(ideal, erdos, n, .01);
    end
end





% ERDOS/IDEAL : V = 1 E = 0
% Ran all of the 2 comparisons, and found that 2 were outside of our expecations.
% The Probability of such an occurance is : 0
% WHICH IS STATISTICALLY SIGNIFIGANT AT THE PROVIDED CL.
%  
% ERDOS/IDEAL : V = 2 E = 0
% Ran all of the 1 comparisons, and found that 0 were outside of our expecations.
% The Probability of such an occurance is : 0.01
% Which is not signifigant at the provided CL.
%  
% ERDOS/IDEAL : V = 2 E = 1
% Ran all of the 1 comparisons, and found that 0 were outside of our expecations.
% The Probability of such an occurance is : 0.01
% Which is not signifigant at the provided CL.
%  
% ERDOS/IDEAL : V = 3 E = 0
% Ran all of the 1 comparisons, and found that 0 were outside of our expecations.
% The Probability of such an occurance is : 0.01
% Which is not signifigant at the provided CL.
%  
% ERDOS/IDEAL : V = 3 E = 1
% Ran all of the 1 comparisons, and found that 0 were outside of our expecations.
% The Probability of such an occurance is : 0.01
% Which is not signifigant at the provided CL.
%  
% ERDOS/IDEAL : V = 3 E = 2
% Ran all of the 1 comparisons, and found that 0 were outside of our expecations.
% The Probability of such an occurance is : 0.01
% Which is not signifigant at the provided CL.
%  
% ERDOS/IDEAL : V = 3 E = 3
% Ran all of the 1 comparisons, and found that 0 were outside of our expecations.
% The Probability of such an occurance is : 0.01
% Which is not signifigant at the provided CL.
%  
% ERDOS/IDEAL : V = 4 E = 0
% Ran all of the 1 comparisons, and found that 0 were outside of our expecations.
% The Probability of such an occurance is : 0.01
% Which is not signifigant at the provided CL.
%  
% ERDOS/IDEAL : V = 4 E = 1
% Ran all of the 1 comparisons, and found that 0 were outside of our expecations.
% The Probability of such an occurance is : 0.01
% Which is not signifigant at the provided CL.
%  
% ERDOS/IDEAL : V = 4 E = 2
% Ran all of the 2 comparisons, and found that 2 were outside of our expecations.
% The Probability of such an occurance is : 0
% WHICH IS STATISTICALLY SIGNIFIGANT AT THE PROVIDED CL.
%  
% ERDOS/IDEAL : V = 4 E = 3
% Ran all of the 3 comparisons, and found that 3 were outside of our expecations.
% The Probability of such an occurance is : 0
% WHICH IS STATISTICALLY SIGNIFIGANT AT THE PROVIDED CL.
%  
% ERDOS/IDEAL : V = 4 E = 4
% Ran all of the 2 comparisons, and found that 2 were outside of our expecations.
% The Probability of such an occurance is : 0
% WHICH IS STATISTICALLY SIGNIFIGANT AT THE PROVIDED CL.
%  
% ERDOS/IDEAL : V = 4 E = 5
% Ran all of the 1 comparisons, and found that 0 were outside of our expecations.
% The Probability of such an occurance is : 0.01
% Which is not signifigant at the provided CL.
%  
% ERDOS/IDEAL : V = 4 E = 6
% Ran all of the 1 comparisons, and found that 0 were outside of our expecations.
% The Probability of such an occurance is : 0.01
% Which is not signifigant at the provided CL.
%  
% ERDOS/IDEAL : V = 5 E = 0
% Ran all of the 1 comparisons, and found that 0 were outside of our expecations.
% The Probability of such an occurance is : 0.01
% Which is not signifigant at the provided CL.
%  
% ERDOS/IDEAL : V = 5 E = 1
% Ran all of the 1 comparisons, and found that 0 were outside of our expecations.
% The Probability of such an occurance is : 0.01
% Which is not signifigant at the provided CL.
%  
% ERDOS/IDEAL : V = 5 E = 2
% Ran all of the 2 comparisons, and found that 2 were outside of our expecations.
% The Probability of such an occurance is : 0
% WHICH IS STATISTICALLY SIGNIFIGANT AT THE PROVIDED CL.
%  
% ERDOS/IDEAL : V = 5 E = 3
% Ran all of the 4 comparisons, and found that 3 were outside of our expecations.
% The Probability of such an occurance is : 1e-08
% WHICH IS STATISTICALLY SIGNIFIGANT AT THE PROVIDED CL.
%  
% ERDOS/IDEAL : V = 5 E = 4
% Ran all of the 6 comparisons, and found that 6 were outside of our expecations.
% The Probability of such an occurance is : 0
% WHICH IS STATISTICALLY SIGNIFIGANT AT THE PROVIDED CL.
%  
% ERDOS/IDEAL : V = 5 E = 5
% Ran all of the 6 comparisons, and found that 6 were outside of our expecations.
% The Probability of such an occurance is : 0
% WHICH IS STATISTICALLY SIGNIFIGANT AT THE PROVIDED CL.
%  
% ERDOS/IDEAL : V = 5 E = 6
% Ran all of the 6 comparisons, and found that 6 were outside of our expecations.
% The Probability of such an occurance is : 0
% WHICH IS STATISTICALLY SIGNIFIGANT AT THE PROVIDED CL.
%  
% ERDOS/IDEAL : V = 5 E = 7
% Ran all of the 4 comparisons, and found that 3 were outside of our expecations.
% The Probability of such an occurance is : 1e-08
% WHICH IS STATISTICALLY SIGNIFIGANT AT THE PROVIDED CL.
%  
% ERDOS/IDEAL : V = 5 E = 8
% Ran all of the 2 comparisons, and found that 2 were outside of our expecations.
% The Probability of such an occurance is : 0
% WHICH IS STATISTICALLY SIGNIFIGANT AT THE PROVIDED CL.
%  
% ERDOS/IDEAL : V = 5 E = 9
% Ran all of the 1 comparisons, and found that 0 were outside of our expecations.
% The Probability of such an occurance is : 0.01
% Which is not signifigant at the provided CL.
%  
% ERDOS/IDEAL : V = 5 E = 10
% Ran all of the 1 comparisons, and found that 0 were outside of our expecations.
% The Probability of such an occurance is : 0.01
% Which is not signifigant at the provided CL.
%  
% ERDOS/IDEAL : V = 6 E = 0
% Ran all of the 1 comparisons, and found that 0 were outside of our expecations.
% The Probability of such an occurance is : 0.01
% Which is not signifigant at the provided CL.
%  
% ERDOS/IDEAL : V = 6 E = 1
% Ran all of the 1 comparisons, and found that 0 were outside of our expecations.
% The Probability of such an occurance is : 0.01
% Which is not signifigant at the provided CL.
%  
% ERDOS/IDEAL : V = 6 E = 2
% Ran all of the 2 comparisons, and found that 2 were outside of our expecations.
% The Probability of such an occurance is : 0
% WHICH IS STATISTICALLY SIGNIFIGANT AT THE PROVIDED CL.
%  
% ERDOS/IDEAL : V = 6 E = 3
% Ran all of the 5 comparisons, and found that 5 were outside of our expecations.
% The Probability of such an occurance is : 0
% WHICH IS STATISTICALLY SIGNIFIGANT AT THE PROVIDED CL.
%  
% ERDOS/IDEAL : V = 6 E = 4
% Ran all of the 9 comparisons, and found that 8 were outside of our expecations.
% The Probability of such an occurance is : 0
% WHICH IS STATISTICALLY SIGNIFIGANT AT THE PROVIDED CL.
%  
% ERDOS/IDEAL : V = 6 E = 5
% Ran all of the 15 comparisons, and found that 14 were outside of our expecations.
% The Probability of such an occurance is : 0
% WHICH IS STATISTICALLY SIGNIFIGANT AT THE PROVIDED CL.
%  
% ERDOS/IDEAL : V = 6 E = 6
% Ran all of the 21 comparisons, and found that 20 were outside of our expecations.
% The Probability of such an occurance is : 0
% WHICH IS STATISTICALLY SIGNIFIGANT AT THE PROVIDED CL.
%  
% ERDOS/IDEAL : V = 6 E = 7
% Ran all of the 24 comparisons, and found that 19 were outside of our expecations.
% The Probability of such an occurance is : 0
% WHICH IS STATISTICALLY SIGNIFIGANT AT THE PROVIDED CL.
%  
% ERDOS/IDEAL : V = 6 E = 8
% Ran all of the 24 comparisons, and found that 23 were outside of our expecations.
% The Probability of such an occurance is : 0
% WHICH IS STATISTICALLY SIGNIFIGANT AT THE PROVIDED CL.
%  
% ERDOS/IDEAL : V = 6 E = 9
% Ran all of the 21 comparisons, and found that 20 were outside of our expecations.
% The Probability of such an occurance is : 0
% WHICH IS STATISTICALLY SIGNIFIGANT AT THE PROVIDED CL.
%  
% ERDOS/IDEAL : V = 6 E = 10
% Ran all of the 15 comparisons, and found that 13 were outside of our expecations.
% The Probability of such an occurance is : 0
% WHICH IS STATISTICALLY SIGNIFIGANT AT THE PROVIDED CL.
%  
% ERDOS/IDEAL : V = 6 E = 11
% Ran all of the 9 comparisons, and found that 9 were outside of our expecations.
% The Probability of such an occurance is : 0
% WHICH IS STATISTICALLY SIGNIFIGANT AT THE PROVIDED CL.
%  
% ERDOS/IDEAL : V = 6 E = 12
% Ran all of the 5 comparisons, and found that 5 were outside of our expecations.
% The Probability of such an occurance is : 0
% WHICH IS STATISTICALLY SIGNIFIGANT AT THE PROVIDED CL.
%  
% ERDOS/IDEAL : V = 6 E = 13
% Ran all of the 2 comparisons, and found that 2 were outside of our expecations.
% The Probability of such an occurance is : 0
% WHICH IS STATISTICALLY SIGNIFIGANT AT THE PROVIDED CL.
%  
% ERDOS/IDEAL : V = 6 E = 14
% Ran all of the 1 comparisons, and found that 0 were outside of our expecations.
% The Probability of such an occurance is : 0.01
% Which is not signifigant at the provided CL.
%  
% ERDOS/IDEAL : V = 6 E = 15
% Ran all of the 1 comparisons, and found that 0 were outside of our expecations.
% The Probability of such an occurance is : 0.01
% Which is not signifigant at the provided CL.
% 
% 
% ERDOS/IDEAL : V = 7 E = 0
% Ran all of the 1 comparisons, and found that 0 were outside of our expecations.
% The Probability of such an occurance is : 0.01
% Which is not signifigant at the provided CL.
%  
% ERDOS/IDEAL : V = 7 E = 1
% Ran all of the 1 comparisons, and found that 0 were outside of our expecations.
% The Probability of such an occurance is : 0.01
% Which is not signifigant at the provided CL.
%  
% ERDOS/IDEAL : V = 7 E = 2
% Ran all of the 2 comparisons, and found that 0 were outside of our expecations.
% The Probability of such an occurance is : 0.0199
% Which is not signifigant at the provided CL.
%  
% ERDOS/IDEAL : V = 7 E = 3
% Ran all of the 5 comparisons, and found that 5 were outside of our expecations.
% The Probability of such an occurance is : 0
% WHICH IS STATISTICALLY SIGNIFIGANT AT THE PROVIDED CL.
%  
% ERDOS/IDEAL : V = 7 E = 4
% Ran all of the 10 comparisons, and found that 10 were outside of our expecations.
% The Probability of such an occurance is : 0
% WHICH IS STATISTICALLY SIGNIFIGANT AT THE PROVIDED CL.
%  
% ERDOS/IDEAL : V = 7 E = 5
% Ran all of the 21 comparisons, and found that 21 were outside of our expecations.
% The Probability of such an occurance is : 0
% WHICH IS STATISTICALLY SIGNIFIGANT AT THE PROVIDED CL.
%  
% ERDOS/IDEAL : V = 7 E = 6
% Ran all of the 41 comparisons, and found that 30 were outside of our expecations.
% The Probability of such an occurance is : 0
% WHICH IS STATISTICALLY SIGNIFIGANT AT THE PROVIDED CL.
%  
% ERDOS/IDEAL : V = 7 E = 7
% Ran all of the 65 comparisons, and found that 44 were outside of our expecations.
% The Probability of such an occurance is : 0
% WHICH IS STATISTICALLY SIGNIFIGANT AT THE PROVIDED CL.
%  
% ERDOS/IDEAL : V = 7 E = 8
% Ran all of the 97 comparisons, and found that 54 were outside of our expecations.
% The Probability of such an occurance is : 0
% WHICH IS STATISTICALLY SIGNIFIGANT AT THE PROVIDED CL.
%  
% ERDOS/IDEAL : V = 7 E = 9
% Ran all of the 131 comparisons, and found that 62 were outside of our expecations.
% The Probability of such an occurance is : 0
% WHICH IS STATISTICALLY SIGNIFIGANT AT THE PROVIDED CL.
%  
% ERDOS/IDEAL : V = 7 E = 10
% Ran all of the 148 comparisons, and found that 66 were outside of our expecations.
% The Probability of such an occurance is : 0
% WHICH IS STATISTICALLY SIGNIFIGANT AT THE PROVIDED CL.
%  
% ERDOS/IDEAL : V = 7 E = 11
% Ran all of the 148 comparisons, and found that 68 were outside of our expecations.
% The Probability of such an occurance is : 0
% WHICH IS STATISTICALLY SIGNIFIGANT AT THE PROVIDED CL.
%  
% ERDOS/IDEAL : V = 7 E = 12
% Ran all of the 131 comparisons, and found that 68 were outside of our expecations.
% The Probability of such an occurance is : 0
% WHICH IS STATISTICALLY SIGNIFIGANT AT THE PROVIDED CL.
%  
% ERDOS/IDEAL : V = 7 E = 13
% Ran all of the 97 comparisons, and found that 46 were outside of our expecations.
% The Probability of such an occurance is : 0
% WHICH IS STATISTICALLY SIGNIFIGANT AT THE PROVIDED CL.
%  
% ERDOS/IDEAL : V = 7 E = 14
% Ran all of the 65 comparisons, and found that 40 were outside of our expecations.
% The Probability of such an occurance is : 0
% WHICH IS STATISTICALLY SIGNIFIGANT AT THE PROVIDED CL.
%  
% ERDOS/IDEAL : V = 7 E = 15
% Ran all of the 41 comparisons, and found that 30 were outside of our expecations.
% The Probability of such an occurance is : 0
% WHICH IS STATISTICALLY SIGNIFIGANT AT THE PROVIDED CL.
%  
% ERDOS/IDEAL : V = 7 E = 16
% Ran all of the 21 comparisons, and found that 20 were outside of our expecations.
% The Probability of such an occurance is : 0
% WHICH IS STATISTICALLY SIGNIFIGANT AT THE PROVIDED CL.
%  
% ERDOS/IDEAL : V = 7 E = 17
% Ran all of the 10 comparisons, and found that 9 were outside of our expecations.
% The Probability of such an occurance is : 0
% WHICH IS STATISTICALLY SIGNIFIGANT AT THE PROVIDED CL.
%  
% ERDOS/IDEAL : V = 7 E = 18
% Ran all of the 5 comparisons, and found that 5 were outside of our expecations.
% The Probability of such an occurance is : 0
% WHICH IS STATISTICALLY SIGNIFIGANT AT THE PROVIDED CL.
%  
% ERDOS/IDEAL : V = 7 E = 19
% Ran all of the 2 comparisons, and found that 0 were outside of our expecations.
% The Probability of such an occurance is : 0.0199
% Which is not signifigant at the provided CL.
%  
% ERDOS/IDEAL : V = 7 E = 20
% Ran all of the 1 comparisons, and found that 0 were outside of our expecations.
% The Probability of such an occurance is : 0.01
% Which is not signifigant at the provided CL.