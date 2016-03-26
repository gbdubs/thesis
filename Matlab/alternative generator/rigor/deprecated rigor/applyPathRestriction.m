function [ o ] = applyPathRestriction ( i, rest )
    t = strfind( i, rest );
    r = cellfun(@isempty,t);
    o = i(~r);
end

