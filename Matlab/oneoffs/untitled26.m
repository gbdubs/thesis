ps = [.05, .1, .15, .2, .25, .3, .4, .5, .6, .7, .75, .8, .85, .9, .95];
ns = 4 : 10;
IdealResult = loadStep(ns, ps, 'Ideal','ANA',10000);
StandardResult = loadStep(ns, ps, 'Standard','ANA',10000);
for i = 1 : 7
    figure;
    iR = log(IdealResult(i,:));
    sR = log(StandardResult(i,:));
    plot(ps, [sR; iR]);
    assignin('base',['iR', num2str(i+3)],iR);
    assignin('base',['sR', num2str(i+3)],sR);
    title(['Log ANA Standard and Ideal, N=',num2str(i+3)]);
    savefig(['alternative generator/analysis/ANA/',num2str(i+3)]);
end
close all;