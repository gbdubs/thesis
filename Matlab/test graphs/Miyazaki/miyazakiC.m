function [ allConnections, nextPlugs ] = miyazakiC( connections, plugs )
    
    newConnections = [1, 2; 1, 7; 2, 5; 2, 6; 3, 4; 3, 10; 4, 6; 4, 8; 7, 8; 7, 9; 9, 10];
    backPlugs = [1, 3, 6, 9];
    nextPlugs = [5, 8];
    
    starter = max(max(connections));
    
    newConnections = newConnections + starter;
    backPlugs = backPlugs + starter;
    nextPlugs = nextPlugs + starter;
    
    plugConnections = [plugs(1), backPlugs(1); plugs(2), backPlugs(2)];
    
    allConnections = vertcat(connections, plugConnections, newConnections);
end

