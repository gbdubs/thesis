%Tests that the SSGG's RGG Probability thing works.
n = 10000;
p = rand();
v = 3;

graphs = zeros(n, 1);

ssgg = SymmetricSmallGraphGenerator(p);

for i = 1 : n
    graphs(i) = sum(sum(ssgg.generate(v)));
end

disp(['expected', num2str((v * (v-1))/2 * p)]);
disp(['actual', num2str(mean(graphs)/2)]);