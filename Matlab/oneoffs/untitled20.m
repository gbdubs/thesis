A = graph6('IQHDeGyRW');
B = graph6('IBJTShiKO');

% Shows the Isomorphism.
tA = [1, 8, 6, 10, 5, 3, 7, 4, 2, 9];
tB = [1, 7, 5, 3, 10, 8, 6, 2, 9, 4];
disp(A(tA, tA) - B(tB, tB))

CA = cannonical(A);
CB = cannonical(B);
CEA = graph6Encode(CA);
CEB = graph6Encode(CB);

