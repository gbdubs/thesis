% overnight runner for 3-14-16 (PI DAY ROUNDED)

for n = 5 : 8
    for p = .15 : .01 : .85
        IdealRandomGenerator(n,p,9999,1);
        StandardRandomGenerator(n, p, 9999, 1);
    end
end

runna;