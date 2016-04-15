close all;

binomialN = 5 : 11;

eMax = .5 * binomialN .* (binomialN-1);

sigmaExpected = .5 * sqrt(eMax);

normSigmaExpected = sigmaExpected ./ eMax;



distributionSigmas = [
    5.0000,    0.2104;
    6.0000,    0.1666;
    7.0000,    0.1310;
    8.0000,    0.1065;
    9.0000,    0.0893;
   10.0000,    0.0775;
   11.0000,    0.0688;
];

distribution95Errors = [
    5.0000,    .0210 ;
    6.0000,    .0034;
    7.0000,    .0015;
    8.0000,    .0005;
    9.0000,    .00016;
   10.0000,    .00003;
   11.0000,    .00005;
];

figure1 = figure;

% Create axes
axes1 = axes('Parent',figure1);
hold(axes1,'on');


X1 = 5 : 11;
Y1 = distributionSigmas(:,2);
E1 = distribution95Errors(:,2);

f = fitToExponentialOfNumberOfEdges(X1, Y1);
% Create plot
plot(X1,Y1,'DisplayName','Fit Sigma of Algebraic Edge Dist.','MarkerSize',30,...
    'Marker','.',...
    'LineStyle','none',...
    'Color',[0.301960796117783 0.745098054409027 0.933333337306976]);

plot(binomialN, normSigmaExpected, 'DisplayName','Normalized Matrix Distribution Sigma','MarkerSize',30,...
    'Marker','.',...
    'LineStyle','none');

fX = 4 : .05 : 12;
fY = f(fX);
plot(fX, fY, 'DisplayName','Power Curve Best Fit-Alg', 'LineWidth',2);

% Create errorbar
errorbar(X1,Y1,E1,'DisplayName','95% Confidence Interval','Marker','+',...
    'LineStyle','none',...
    'LineWidth',2,...
    'Color',[0 0.447058826684952 0.74117648601532]);

X1 = binomialN;
Y1 = normSigmaExpected;
f = fitToExponentialOfNumberOfEdges(X1, Y1);
fY = f(fX);
plot(fX, fY, 'DisplayName','Power Curve Best Fit-Matrix', 'LineWidth',2);
% Create xlabel
xlabel('N Vertices');

% Create ylabel
ylabel('Sigma fit to Edge-Distribution');




%% Uncomment the following line to preserve the X-limits of the axes
xlim(axes1,[4 12]);
%% Uncomment the following line to preserve the Y-limits of the axes
ylim(axes1,[0 0.25]);
box(axes1,'on');
% Set the remaining axes properties
set(axes1,'FontSize',16);
% Create legend
legend1 = legend(axes1,'show');
set(legend1,...
    'Position',[0.184944710115731 0.205069124423963 0.438035541230769 0.105990783410138]);




hold(axes1, 'off');

print('ngraphs/decreasingsigma','-dpng');