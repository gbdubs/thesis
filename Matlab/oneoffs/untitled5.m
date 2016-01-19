data = data_1;
v = 1;

result = findDistributionOfMaximalDifferentiatingPower(data);
range = 0 : max(result);

cellrange = cell(size(range));
for i = 0 : max(result)
    cellrange(i+1) = {num2str(i)};
end

figure;
c = categorical(result,range,cellrange);
h = histogram(c);
counts = h.Values;
title(['Distribution of Max. Diff. Power for V = ', num2str(v)]);

tx = text(1,-2,num2str(counts));

path = strcat('visualization/powerdistributions/V',num2str(v),'.png');
print(path,'-dpng');
close all;