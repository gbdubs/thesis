function [ output_args ] = verifyAutomorphism( G, aut )

n = size(G, 1);
d = size(aut, 1);
if (d == 1)
    aut = vertcat(1:n, aut);
end
aut = transpose(sortrows(transpose(aut), 1));

translated = zeros(size(G));
for i = 1 : n
    for j = 1 : n
        if G(i, j) == 1
            translated(aut(2, i), aut(2, j)) = 1;
        end
    end
end

diff = G - translated;
diff = diff .^ 2;


output_args = (sum(sum(diff)) == 0);

end

