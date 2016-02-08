data = map4;

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