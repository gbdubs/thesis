function [ output_args ] = graph6( s )
    v = s(1:1) - 63;
    e = (v * (v-1)) / 2; 

    toAddSize = 6;
		
	graph = zeros(v,v);
	count = 0;
	index = 2;
		
	x = 2;
	y = 1;
		
	while count < e 
		c = s(index:index) - 63;
        disp(c);
		toAdd = zeros(1, toAddSize);
		for i = toAddSize:-1:1
            toAdd(i) = bitand(c, 1);
			c = bitshift(c, -1);
        end
        disp(toAdd);
		for i = 1:toAddSize
			if x == y
				graph(x,y) = 0;
				x = x + 1;
				y = 1;
				if x == v+1
                    output_args = graph;
					return;
                end
            end
			graph(x,y) = toAdd(i);
			graph(y,x) = toAdd(i);
			count = count + 1;
			y = y + 1;
        end
		index = index + 1;
    end
    
	output_args = graph;
end

