SR = loadStep(4:9, .2:.1:.8, 'Standard', 'NR', 10000, 1);
IR = loadStep(4:9, .2:.1:.8, 'Ideal', 'NR', 10000, 1);

temp = ((IR - SR) ./ IR);

temp(IR < 20) = NaN;

percentLessLikelyToGenerateRegularGraph = temp;