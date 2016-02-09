M1 = miyazaki(2, [1]);
M2 = miyazaki(2, [2]);
cannon1 = cannonical(M1);
cannon2 = cannonical(M2);

any(any(cannon2 - cannon1))

M3 = miyazaki(2, [1]);
rp = randperm(size(M3,1));
M3 = M3(rp, rp);
cannon3 = cannonical(M3);

any(any(cannon3 - cannon1))