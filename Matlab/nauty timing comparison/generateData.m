for p = .01 : .01 : .99
    disp(p);
    generateDataForNautyTimingComparison(10,p,100000,1);
end