temp = [];

for i = 1 : 10
    load(['alternative generator/data/V2/trial', num2str(i)]);
    temp = vertcat(temp, graphSet);
end

graphSet = temp;