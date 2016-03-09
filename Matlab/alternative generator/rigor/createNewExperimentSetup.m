function createNewExperimentSetup(ROOT_PATH, N, P, ALG )

    p1 = [ROOT_PATH, '/n=', num2str(N)];
    p2 = [p1, '/p=', num2str(P)];
    p3 = [p2, '/alg=', ALG];
    p4 = [p3, '/raw'];
    p5 = [p3, '/cannon'];
    p6 = [p3, '/results'];
    p7 = [p3, '/variables.mat'];
    
    if ~exist(p1, 'dir')
        mkdir(p1);
    end
    
    if ~exist(p2, 'dir')
        mkdir(p2);
    end
    
    if ~exist(p3, 'dir')
        mkdir(p3);
    end
    
    if ~exist(p4, 'dir')
        mkdir(p4);
    end
    
    if ~exist(p5, 'dir')
        mkdir(p5);
    end
    
    if ~exist(p6, 'dir')
        mkdir(p6);
    end
    
    if ~exist(p7, 'file')
        save(p7, 'ALG', 'P', 'N');
    end
end

