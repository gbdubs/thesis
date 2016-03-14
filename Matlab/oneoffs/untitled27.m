METRIC = 'ANA';

% N = 10

ps1 = .15:.01:.85;
temp1 = loadStep(10, ps1, 'Standard', METRIC, 10001, 0);
temp2 = loadStep(10, ps1, 'Standard', METRIC,  9999, 0);
ps3 = [.05, .1, .15, .2, .25, .3, .4, .5, .6, .7, .75, .8, .85, .9, .95];
temp3 = loadStep(10, ps3, 'Standard', METRIC, 10000, 0);

nt1 = numel(temp1);
nt2 = numel(temp2) + nt1;
nt3 = numel(temp3) + nt2;

standardN10 = zeros(nt3, 2);
standardN10(1 : nt1, 1) = ps1;

standardN10(1 : nt1, 2) = temp1;
standardN10(nt1+1 : nt2, 1) = ps1;
standardN10(nt1+1 : nt2, 2) = temp2;

standardN10(nt2+1 : nt3, 1) = ps3;
standardN10(nt2+1 : nt3, 2) = temp3;

standardN10Xs = standardN10(:, 1);
standardN10Ys = log(standardN10(:, 2));



ps1 = .15:.01:.85;
temp1 = loadStep(10, ps1, 'Ideal', METRIC, 10001, 0);
temp2 = loadStep(10, ps1, 'Ideal', METRIC,  9999, 0);
ps3 = [.05, .1, .15, .2, .25, .3, .4, .5, .6, .7, .75, .8, .85, .9, .95];
temp3 = loadStep(10, ps3, 'Ideal', METRIC, 10000, 0);

nt1 = numel(temp1);
nt2 = numel(temp2) + nt1;
nt3 = numel(temp3) + nt2;

idealN10 = zeros(nt3, 2);
idealN10(1 : nt1, 1) = ps1;

idealN10(1 : nt1, 2) = temp1;
idealN10(nt1+1 : nt2, 1) = ps1;
idealN10(nt1+1 : nt2, 2) = temp2;

idealN10(nt2+1 : nt3, 1) = ps3;
idealN10(nt2+1 : nt3, 2) = temp3;

idealN10Xs = idealN10(:, 1);
idealN10Ys = log(idealN10(:, 2));


% N = 9.

ps1 = .15:.01:.85;
temp1 = loadStep(9, ps1, 'Standard', METRIC, 10001, 0);
temp2 = loadStep(9, ps1, 'Standard', METRIC,  9999, 0);
temp3 = loadStep(9, ps1, 'Standard', METRIC, 10000, 0);
ps4 = [.05, .1, .15, .2, .25, .3, .4, .5, .6, .7, .75, .8, .85, .9, .95];
temp4 = loadStep(9, ps4, 'Standard', METRIC, 10000, 0);

nt1 = numel(temp1);
nt2 = numel(temp2) + nt1;
nt3 = numel(temp3) + nt2;
nt4 = numel(temp4) + nt3;

standardN9 = zeros(nt4, 2);
standardN9(1 : nt1, 1) = ps1;

standardN9(1 : nt1, 2) = temp1;
standardN9(nt1+1 : nt2, 1) = ps1;
standardN9(nt1+1 : nt2, 2) = temp2;

standardN9(nt2+1 : nt3, 1) = ps1;
standardN9(nt2+1 : nt3, 2) = temp3;

standardN9(nt3+1 : nt4, 1) = ps4;
standardN9(nt3+1 : nt4, 2) = temp4;

standardN9Xs = standardN9(:, 1);
standardN9Ys = log(standardN9(:, 2));



ps1 = .15:.01:.85;
temp1 = loadStep(9, ps1, 'Ideal', METRIC, 10001, 0);
temp2 = loadStep(9, ps1, 'Ideal', METRIC,  9999, 0);
temp3 = loadStep(9, ps1, 'Ideal', METRIC, 10000, 0);
ps4 = [.05, .1, .15, .2, .25, .3, .4, .5, .6, .7, .75, .8, .85, .9, .95];
temp4 = loadStep(9, ps4, 'Ideal', METRIC, 10000, 0);

nt1 = numel(temp1);
nt2 = numel(temp2) + nt1;
nt3 = numel(temp3) + nt2;
nt4 = numel(temp4) + nt3;

idealN9 = zeros(nt4, 2);
idealN9(1 : nt1, 1) = ps1;

idealN9(1 : nt1, 2) = temp1;
idealN9(nt1+1 : nt2, 1) = ps1;
idealN9(nt1+1 : nt2, 2) = temp2;

idealN9(nt2+1 : nt3, 1) = ps1;
idealN9(nt2+1 : nt3, 2) = temp3;

idealN9(nt3+1 : nt4, 1) = ps4;
idealN9(nt3+1 : nt4, 2) = temp4;


idealN9Xs = idealN9(:, 1);
idealN9Ys = log(idealN9(:, 2));


clear('temp1','temp2','temp3', 'temp1','ps1','ps3','ps4','nt1','nt2','nt3', 'nt4','METRIC');
