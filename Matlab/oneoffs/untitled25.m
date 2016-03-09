% Create Ideal Sets, and Cannonize Them.

for v = 4 : 9
    for p = .2 : .1 : .8 
        IdealRandomGenerator(v, p, 10000, 1);
    end
end

for v = 4 : 9
    for p = .2 : .1 : .8 
        StandardRandomGenerator(v, p, 10000, 1);
    end
end

cannonizeRandomGraphData();

for v = 10 : 5 : 30
    for p = .2 : .1 : .8 
        StandardRandomGenerator(v, p, 10000, 1);
    end
end

cannonizeRandomGraphData();