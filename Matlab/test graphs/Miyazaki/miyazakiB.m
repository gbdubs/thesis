function [ allConnections, nextPlugs] = miyazakiB( connections, plugs , twist)
    
    newConnections = [1, 2; 1, 6; 1, 8; 2, 4; 3, 4; 4, 10; 5, 7; 5, 9; 6, 9; 7, 8; 9, 10];
    backPlugs = [3, 6];
    nextPlugs = [2, 5, 8, 10];
    disp(size(newConnections));
    
    starter = max(max(connections));
    
    newConnections = newConnections + starter;
    backPlugs = backPlugs + starter;
    nextPlugs = nextPlugs + starter;
    
    plugConnections = [plugs(1), backPlugs(1); plugs(2), backPlugs(2)];
    if (twist)
        plugConnections = [plugs(1), backPlugs(2); plugs(2), backPlugs(1)];
    end
    
    allConnections = vertcat(connections, plugConnections, newConnections);
end

