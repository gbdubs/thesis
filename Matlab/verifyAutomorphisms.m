function verifyAutomorphisms( G, auts )
    for i = 1 : size(auts, 2)
        if (verifyAutomorphism(G, cell2mat(auts(i))))
            disp 'Automorphism Confirmed';
        else
            disp 'Automorphism Rejected';
        end
    end
end

