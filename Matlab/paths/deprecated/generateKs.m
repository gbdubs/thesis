function [ output_args ] = generateKs( graph , runUntil )
    output_args = generateLargeKs(graph, runUntil);

%     n = length(graph);
% 
%     longGraph = zeros(n, n, 'uint64');
%     for i = 1 : n
%         for j = 1 : n
%             longGraph(i,j) = graph(i, j);
%         end
%     end
%     
%     runningVariable = longGraph;
% 
%     result = zeros(n, runUntil, 'uint64');
%     for i = 1 : runUntil
%         for j = 1 : n
%             result(j, i) = runningVariable(j, j);
%         end
%         newRV = zeros(n, n, 'uint64');
%         for a = 1 : n
%             for b = 1 : n
%                 temp = uint64(0);
%                 for c = 1 : n
%                     temp(1) = temp(1) + (runningVariable(a,c)*longGraph(c, b));
%                 end
%                 newRV(a, b) = temp(1);
%             end
%         end
%        
%         runningVariable = newRV;
%     end
% 
%     output_args = result;
end

