function [ A ] = miyazaki( nComponents, toTwist )
    shouldTwist = zeros(nComponents, 1);
    shouldTwist(toTwist) = 1;
    
    [connections, plugs] = miyazakiA();
    for i = 1 : nComponents
        [connections, plugs] = miyazakiB(connections, plugs);
        [connections, plugs] = miyazakiC(connections, plugs, shouldTwist(i));
    end
    connections = miyazakiD(connections, plugs);
    
    A = graphFromConnections(connections);

end

