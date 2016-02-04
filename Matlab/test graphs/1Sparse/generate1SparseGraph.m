function [ output_args ] = generate1SparseGraph( n )
    % Generates graphs according to the 1Sparse Graph Generation Technique
    % proposed by the authors of the 2013 Paper "Solving Graph Isomorphism
    % Using Parameterized Matching", by Mendivelso, Kim, Elnikety, He, Hwang,
    % and Pinzon.

    % Graph has n vertices and 3n edges.

   

    function addConnection(a, b)
        if (nConnections(a) >= 3)
            disp(['ERROR!!! A [',num2str(a),'] does not have an additional connection to make.']);
            return;
        end

        if (nConnections(b) >= 3)
            disp(['ERROR!!! B [',num2str(b),'] does not have an additional connection to make.']);
            return;
        end

        nConnections(a) = nConnections(a) + 1;
        nConnections(b) = nConnections(b) + 1;

        connections(a, nConnections(a)) = b;
        connections(b, nConnections(b)) = a;
    end

    function [ pair_exists ] = connectionExists(a, b)
        pair_exists = sum(connections(a,:) == b);
        if (a == b)
            pair_exists = 1;
        end
    end


    

    inds = 1 : n;
    
    A = zeros(n, n);
    
    while(sum(sum(A)) < 3 * n)
        
        nConnections = zeros(n, 1);
        connections = zeros(n, 3);
        
        for i = 1 : n
            parent = floor(i / 2);
            if (parent > 0)
                addConnection(i, parent);
            end
        end
        
        A = zeros(n, n);

        remaining = horzcat(inds(nConnections <= 2), inds(nConnections == 1));

        attempts = 0;
        maxAttempts = 100 * n * n;

        while ((size(remaining,2) > 0) && (maxAttempts > attempts))
            i1 = 1;
            i2 = 1;
            while(connectionExists(remaining(i1), remaining(i2)) && (maxAttempts > attempts))
                i1 = ceil(rand() * size(remaining, 2));
                i2 = ceil(rand() * size(remaining, 2));
                attempts = attempts + 1;
            end
            addConnection(remaining(i1), remaining(i2));
            l1 = min(i1, i2);
            l2 = max(i1, i2);
            remaining = remaining([1:(l2 - 1), (l2 + 1):end]);
            remaining = remaining([1:(l1 - 1), (l1 + 1):end]);
        end

        if (any(connections == 0) == 0)
            for i = 1 : n
                for j = 1 : 3
                    k = connections(i,j);
                    A(i,k) = 1;
                end
            end
        end
        
    end
    
    output_args = A;
end

