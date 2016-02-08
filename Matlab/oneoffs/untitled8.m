data = map7;

x = sort(double(cell2mat(data.values)));
ux = unique(x);

[a, b] = hist(x, ux);

disp('Values');
disp(b);
disp('Counts');
disp(a);


% MAP 1
% Values
%     1
% Counts
%     1

% MAP 2
% Values
%      1
% Counts
%      2

% MAP 3
% Values
%      1     3
% Counts
%      2     2

% MAP 4
% Values
%      1     3     4     6    12
% Counts
%      2     2     2     2     3


% MAP 5
% Values
%     1     5    10    12    15    20    30    60
% Counts
%     2     2     6     1     4     2     6    11

% MAP 6
% Values
%     1     6    10    15    20    30    45    60    72    90   120   180   360   720
% Counts
%     2     2     2     8     2     2     6    18     2    14     8    36    46     8
 
% MAP 7
% Values
%       1     7    21    35    42    70   105   140   210   252   315   360   420   504   630   840  1260  2520  5040
% Counts
%       2     2     6     6     2     4    28     6    24     4    20     2    70     2    74    38   248   354   152