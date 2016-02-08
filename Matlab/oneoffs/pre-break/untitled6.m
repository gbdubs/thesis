data = data_6;
v =6;

result = findDistributionOfMaximalDifferentiatingPower(data);
diameters = zeros(size(result,1), 1);

for i = 1 : size(result, 1)
    diameters(i) = graphDiameter(graph6(data(i,:)));
end

toGraph = [];
for diam = 0 : v
    for paths = 0 : v
        s = sum(diameters == diam & paths == result);
        if (s > 0)
            toGraph = vertcat(toGraph, [diam, paths, s]);
        end
    end
end

scatter(toGraph(:,1), toGraph(:,2), 10 * toGraph(:,3));
    
a = toGraph(:,3);
b = num2str(a); 
c = cellstr(b);
dx = 0.1; dy = 0.1; % displacement so the text does not overlay the data points
text(toGraph(:,1)+dx, toGraph(:,2)+dy, c);

title(['MaxDiffPower against GraphDiam for V=', num2str(v)]);
axis([-.5, max(toGraph(:,1)) + .5, -.5,  max(toGraph(:,2)) + .5]);


path = strcat('visualization/diameterandmaxdiffpower/V',num2str(v),'.png');
print(path,'-dpng');
close all;