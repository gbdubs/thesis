v10e16 = [
	'IIa?hONKo'
    'Il?GOKrN?'
];

v10e17 = [
	'IIa?X_VIw'
    'Il?GOKrNG'
];

v10e18 = [
    'IIok?[RLg'
    'I_[haGR`w'
    'I@QKj?]]O'
    'I@Pjk?XeW'
];

v10e19 = [
	'IICkKSN^?'
    'I_ChhtKrG'
    'I_[qCKjDw'
    'IIq?XgjDw'
];

v10e20 = [
    'I@QKbK]^_'
    'I@PjcKXfg'
    'IBO_[uF^G'
    'ICO_zpdfg'
    'IKCeMO|N_'
    'IlQGhS]JO'
    'IXeI?LrFo'
    'IpKgWNPSw'
    'IKr@hoNKo'
    'IlQGhS{Bo'
    'IJaJcWVIo'
    'I_CXX^o{G'
    'IJPKkmgiG'
    'ILQIstchG'
    'IcXTHpeeO'
    'IceahlgYG'
];

v10e21 = [
	'ICDrIWjew'
    'IBA[YWj[w'
    'I@TjcKXfg'
    'I@UKbK]^_'
    'IKr@hoNKw'
    'IlQGhS{Bw'
    'I`T\DCN{G'
    'I`T\DDdeg'
    'IJaJcWVIw'
    'I`KwXfBow'
    'IlQGhS]JW'
    'IKCmMO|N_'
    'IpKXeDFBw'
    'I[d@bK]Bw'
];

v10e22 = [
	'IoGRrh[bw'
    'IYGUUG^No'
    'I@QKg|e^g'
    'I@PjgqFfw'
    'IiGLG}R^G'
    'Iq?JXxYlW'
    'IiGL_}F^G'
    'Iq?JpxMlW'
    'I?S}fEb^G'
    'ICOi~_m{W'
    'I`CbjrKbw'
    'IJCeMQNNo'
    'IIedUGvUo'
    'IIeahrJho'
    'IEYbLTXdg'
    'IEYakthhg'
];

v10e23 = [
	'I?qffPs~?'
	'I?ovFa{~?'
	'I?qbDpxxw'
	'ICOfDpxxw'
	'I?ovCxxn_'
	'ICQebriNo'
	'I?qbbq\n_'
	'ICQeRrqNo'
	'I?otRjTz_'
	'ICQTbZqzO'
	'ICQfMhwMw'
	'ICp`f`m}_'
	'ICpdbi{V_'
	'ICpbdh]n?'
	'ICpdbj[N_'
	'ICXedrMn?'
];

v10e24 = [
	'I?qabYmVo'
	'I?qacymVo'
	'I?qdV`k}G'
	'I?q`tVo}_'
	'I?qrfRWr_'
	'I?qrfRWVO'
	'ICR`vGy}?'
	'ICR`thi}?'
	'ICQrThix_'
	'ICQrThiZO'
	'ICpdf_]lO'
	'ICpdf_][o'
	'ICR`thiZO'
	'ICpdepkr_'
];

v10e25 = [
	'I?qafbE|_'
	'ICOfDpwpw'
	'I?qacimVo'
	'ICOedPyjo'
	'I?ovDb[^?'
	'ICQf@\[]_'
	'I?otU`tZ_'
	'ICQeeTwNG'
	'I?ovEa{^?'
	'ICQeV`wFg'
	'I?otQji\O'
	'ICQTddkZG'
	'ICR`vGyu?'
	'ICR`tjWY_'
	'ICR`uiwY_'
	'ICdedhkY_'
];

v10e26 = [
	'I?qadXYYo'
	'I?qadXYeo'
	'I?qaayiZO'
	'I?qaayifO'
];

v10e27 = [
	'I?qadbE\_'
	'ICOedPwbo'
];

v10e28 = [
	'I?r@`aiUg'
	'I?r@`aiXg'
];

v10e29 = [
	'I?qa``kWo'
	'ICOeeOwFG'
];

for i = 16 : 29
    name = ['v10e',num2str(i)];
    eval([name, ' = convertDataToCannonical(',name,');']); 
end

v10CoPaths = vertcat(v10e16, v10e17, v10e18, v10e19, v10e20, v10e21, v10e22, v10e23, v10e24, v10e25, v10e26, v10e27, v10e28, v10e29);  

inverses = zeros(size(v10CoPaths));

for i = 1 : size(v10CoPaths, 1)
    inverses(i,:) = graph6Encode(cannonical(invertGraph(graph6(v10CoPaths(i,:)))));
end

nonReppedInverses = setdiff(inverses, v10CoPaths, 'rows');

v10CoPaths = unique([v10CoPaths; nonReppedInverses], 'rows');

clear inverses;
clear nonReppedInverses;
clear i;