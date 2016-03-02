%Tests that the SCG's RCG Probability distribution tools work.
n = 10000;
p = rand();
d1 = 3;
d2 = 4;
expectation = p * d1 * d2;

graphs = zeros(n, 1);

scg = SymmetricConnectionGenerator(p);

for i = 1 : n
    graphs(i) = sum(sum(scg.getLeftSymmetricRandomConnections(d1, d2)));
end

disp(['expected', num2str(expectation)]);
disp(['actual', num2str(mean(graphs))]);

for i = 1 : n
    graphs(i) = sum(sum(scg.getRightSymmetricRandomConnections(d1, d2)));
end

disp(['expected', num2str(expectation)]);
disp(['actual', num2str(mean(graphs))]);

for i = 1 : n
    graphs(i) = sum(sum(scg.getBothSymmetricRandomConnections(d1, d2)));
end

disp(['expected', num2str(expectation)]);
disp(['actual', num2str(mean(graphs))]);