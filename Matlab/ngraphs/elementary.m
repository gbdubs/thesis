nGraphs = [1, 0, 1; 2, 0, 1; 2, 1, 1; 3, 0, 1; 3, 1, 1; 3, 2, 1; 3, 3, 1; 4, 0, 1; 4, 1, 1; 4, 2, 2; 4, 3, 3; 4, 4, 2; 4, 5, 1; 4, 6, 1; 5, 0, 1; 5, 1, 1; 5, 2, 2; 5, 3, 4; 5, 4, 6; 5, 5, 6; 5, 6, 6; 5, 7, 4; 5, 8, 2; 5, 9, 1; 5, 10, 1; 6, 0, 1; 6, 1, 1; 6, 2, 2; 6, 3, 5; 6, 4, 9; 6, 5, 15; 6, 6, 21; 6, 7, 24; 6, 8, 24; 6, 9, 21; 6, 10, 15; 6, 11, 9; 6, 12, 5; 6, 13, 2; 6, 14, 1; 6, 15, 1; 7, 0, 1; 7, 1, 1; 7, 2, 2; 7, 3, 5; 7, 4, 10; 7, 5, 21; 7, 6, 41; 7, 7, 65; 7, 8, 97; 7, 9, 131; 7, 10, 148; 7, 11, 148; 7, 12, 131; 7, 13, 97; 7, 14, 65; 7, 15, 41; 7, 16, 21; 7, 17, 10; 7, 18, 5; 7, 19, 2; 7, 20, 1; 7, 21, 1; 8, 0, 1; 8, 1, 1; 8, 2, 2; 8, 3, 5; 8, 4, 11; 8, 5, 24; 8, 6, 56; 8, 7, 115; 8, 8, 221; 8, 9, 402; 8, 10, 663; 8, 11, 980; 8, 12, 1312; 8, 13, 1557; 8, 14, 1646; 8, 15, 1557; 8, 16, 1312; 8, 17, 980; 8, 18, 663; 8, 19, 402; 8, 20, 221; 8, 21, 115; 8, 22, 56; 8, 23, 24; 8, 24, 11; 8, 25, 5; 8, 26, 2; 8, 27, 1; 8, 28, 1; 9, 0, 1; 9, 1, 1; 9, 2, 2; 9, 3, 5; 9, 4, 11; 9, 5, 25; 9, 6, 63; 9, 7, 148; 9, 8, 345; 9, 9, 771; 9, 10, 1637; 9, 11, 3252; 9, 12, 5995; 9, 13, 10120; 9, 14, 15615; 9, 15, 21933; 9, 16, 27987; 9, 17, 32403; 9, 18, 34040; 9, 19, 32403; 9, 20, 27987; 9, 21, 21933; 9, 22, 15615; 9, 23, 10120; 9, 24, 5995; 9, 25, 3252; 9, 26, 1637; 9, 27, 771; 9, 28, 345; 9, 29, 148; 9, 30, 63; 9, 31, 25; 9, 32, 11; 9, 33, 5; 9, 34, 2; 9, 35, 1; 9, 36, 1; 10, 0, 1; 10, 1, 1; 10, 2, 2; 10, 3, 5; 10, 4, 11; 10, 5, 26; 10, 6, 66; 10, 7, 165; 10, 8, 428; 10, 9, 1103; 10, 10, 2769; 10, 11, 6759; 10, 12, 15772; 10, 13, 34663; 10, 14, 71318; 10, 15, 136433; 10, 16, 241577; 10, 17, 395166; 10, 18, 596191; 10, 19, 828728; 10, 20, 1061159; 10, 21, 1251389; 10, 22, 1358852; 10, 23, 1358852; 10, 24, 1251389; 10, 25, 1061159; 10, 26, 828728; 10, 27, 596191; 10, 28, 395166; 10, 29, 241577; 10, 30, 136433; 10, 31, 71318; 10, 32, 34663; 10, 33, 15772; 10, 34, 6759; 10, 35, 2769; 10, 36, 1103; 10, 37, 428; 10, 38, 165; 10, 39, 66; 10, 40, 26; 10, 41, 11; 10, 42, 5; 10, 43, 2; 10, 44, 1; 10, 45, 1; 11, 0, 1; 11, 1, 1; 11, 2, 2; 11, 3, 5; 11, 4, 11; 11, 5, 26; 11, 6, 67; 11, 7, 172; 11, 8, 467; 11, 9, 1305; 11, 10, 3664; 11, 11, 10250; 11, 12, 28259; 11, 13, 75415; 11, 14, 192788; 11, 15, 467807; 11, 16, 1069890; 11, 17, 2295898; 11, 18, 4609179; 11, 19, 8640134; 11, 20, 15108047; 11, 21, 24630887; 11, 22, 37433760; 11, 23, 53037356; 11, 24, 70065437; 11, 25, 86318670; 11, 26, 99187806; 11, 27, 106321628; 11, 28, 106321628; 11, 29, 99187806; 11, 55, 1; 11, 54, 1; 11, 53, 2; 11, 52, 5; 11, 51, 11; 11, 50, 26; 11, 49, 67; 11, 48, 172; 11, 47, 467; 11, 46, 1305; 11, 45, 3664; 11, 44, 10250; 11, 43, 28259; 11, 42, 75415; 11, 41, 192788; 11, 40, 467807; 11, 39, 1069890; 11, 38, 2295898; 11, 37, 4609179; 11, 36, 8640134; 11, 35, 15108047; 11, 34, 24630887; 11, 33, 37433760; 11, 32, 53037356; 11, 31, 70065437; 11, 30, 86318670];

v11 = nGraphs(nGraphs(:,1) == 11,:);
nG11 = v11(:,3);
nE11 = v11(:,2);
pnE11 = nE11 / max(nE11);

pnG11 = nG11 / sum(nG11);
lpnG11 = log(pnG11);

v10 = nGraphs(nGraphs(:,1) == 10,:);
nG10 = v10(:,3);
nE10 = v10(:,2);
pnE10 = nE10 / max(nE10);

pnG10 = nG10 / sum(nG10);
lpnG10 = log(pnG10);
