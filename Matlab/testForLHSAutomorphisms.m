function [ LHSAutomorphismHolds ] = testForLHSAutomorphisms( conns )
    LHSAutomorphismHolds = testForRHSAutomorphisms(conns');
end

