

for i = 1 : size(pathsNotAutoClasses,2)
    visualizeGraphPaths(graph6(cell2mat(pathsNotAutoClasses(i))), ['quazicounters/QuaziEquivClassCounterExample', num2str(i) ], false);
end