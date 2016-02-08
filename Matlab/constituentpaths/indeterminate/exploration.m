A = graph6(data_6(91,:));

A1 = augmentGraphWithNewVertex(A, 1);
A2 = augmentGraphWithNewVertex(A, 2);
A3 = augmentGraphWithNewVertex(A, 3);
A4 = augmentGraphWithNewVertex(A, 4);
A5 = augmentGraphWithNewVertex(A, 5);
A6 = augmentGraphWithNewVertex(A, 6);

PA = double(generateKs(A, 7));

PA1 = double(generateKs(A1, 7));
PA2 = double(generateKs(A2, 7));
PA3 = double(generateKs(A3, 7));
PA4 = double(generateKs(A4, 7));
PA5 = double(generateKs(A5, 7));
PA6 = double(generateKs(A6, 7));

PA1 = PA1(1:6, :);
PA2 = PA2(1:6, :);
PA3 = PA3(1:6, :);
PA4 = PA4(1:6, :);
PA5 = PA5(1:6, :);
PA6 = PA6(1:6, :);

D1 = sortrows(PA1-PA);
D2 = sortrows(PA2-PA);
D3 = sortrows(PA3-PA);
D4 = sortrows(PA4-PA);
D5 = sortrows(PA5-PA);
D6 = sortrows(PA6-PA);

% Clearly there are limitations... not to the information that this method
% can bring us, but how we can go about generating it, and whether or not
% it is comparable.  My intuition, which might be incorrect, is that this
% methodology doesn't have anything that is unique about it (nothing
% special) It seems like too much for far too little. 


% How could we use this within the context of an invariant?
% In generating paths, we establish a prelimanary ordering of the vertices
% based on their paths context within the context of their current graph.
% We then allow a second round of discrimination (based on the paths
% invariants of the singly tagged augmented graph for each vertex.  Here is
% my concern/thought: 

% We obviously can't maintain references to nodes (an invariant cannot)
% BUT, Paths alongside Paths++ for a given node gives us a ton of
% information about how that vertex interacts with the graph.  Information
% that cannot be created by Paths alone (x), and information which can
% reconstruct more of an immediat neighborhood than Paths Can.

% As an example:

% D6 =
% 
%      0     0     0     0     0     4     8
%      0     0     0     1     0     9     8
%      0     0     0     1     2    18    42
%      0     0     0     1     2    18    42
%      0     0     0     1     4    17    68
%      0     1     0     9     8    81   140
% 
% PA(6,:) =
% 
%      0     4     4    26    48   200   464

% This tells us that:
%
%             X
%           / | \ 
%         X - 6 - X
%             |
%             X
% Rather than another possibility:
%
%             X
%           / |  
%         X - 6 - X
%             | /
%             X

% Thus, we know that Paths++ can deduce MORE than Paths alone, and that as
% an invariant, it can augment our understanding of the graph in ways that
% are determinate... 


% To me it almost signifies the degree of the attaced vertices within the
% attached set.  For example, if lets say (as in the example above) we are
% examining node 6.  We tag it, run paths on it, and take the difference
% between that and the original paths value.  The set of nodes which are
% attached to six (call S6), from the Paths++ values, we can determine the
% degree of these nodes within that set...

% Could we go broader? does Paths++ allow us to determine Paths within this
% set?  Probably not.  Because we are attached to the 