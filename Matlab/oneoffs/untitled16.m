
RSGG = RandomSymmetricalGraphGenerator(.3);

for i = 1 : 100
    A = RSGG.generate(10);
    visualizeGraphPaths(A, ['RSGG ', num2str(i)]);
end