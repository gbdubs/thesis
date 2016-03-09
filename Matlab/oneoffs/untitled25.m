% Create Ideal Sets, and Cannonize Them.

for v = 4 : 8
    for p = .2 : .1 : .8 
        IdealRandomGenerator(v, p, 10000, 1);
    end
end

cannonizeRandomGraphData();

for v = 4 : 8
    for p = .2 : .1 : .8 
        StandardRandomGenerator(v, p, 10000, 1);
    end
end

cannonizeRandomGraphData();