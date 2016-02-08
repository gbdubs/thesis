data = map4;

x = sort(double(cell2mat(data.values)));
ux = unique(x);

[a, b] = hist(x, ux);

disp('Values');
disp(b);
disp('Counts');
disp(a);
disp(['Mean : ', num2str(sum(a.*b) / sum(a))]);

% MAP 1
% Values
%     1
% Counts
%     1
% Average Graph: 1

% MAP 2
% Values
%      1
% Counts
%      2
% Average Graph: 1

% MAP 3
% Values
%      1     3
% Counts
%      2     2
% Average Graph: 2

% MAP 4
% Values
%      1     3     4     6    12
% Counts
%      2     2     2     2     3
% Average Graph: 5.8182

% MAP 5
% Values
%     1     5    10    12    15    20    30    60
% Counts
%     2     2     6     1     4     2     6    11
% Average Graph: 30.1176

% MAP 6
% Values
%     1     6    10    15    20    30    45    60    72    90   120   180   360   720
% Counts
%     2     2     2     8     2     2     6    18     2    14     8    36    46     8
% Average Graph: 210.0513
% Probability Range for a graph: [.000030518, .0220] (720x more likely)
 
% MAP 7
% Values
%       1     7    21    35    42    70   105   140   210   252   315   360   420   504   630   840  1260  2520  5040
% Counts
%       2     2     6     6     2     4    28     6    24     4    20     2    70     2    74    38   248   354   152
% Average Graph: 2008.7663
% Probability Range for a graph: [.00000047684, .0024] (5040x more likely)

% averageGraphs = [1, 2, 3, 4, 5, 6, 7; 1, 1, 2, 5.8182, 30.1176, 210.0513, 2008.7663];
% logavggraphs = [0         0    0.6931    1.7610    3.4051    5.3474    7.6053];
% divbyfact = [1.0000    0.5000    0.3333    0.2424    0.2510    0.2917    0.3986];

% 