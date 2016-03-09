function processDataSet ( P, ALG, SIZE )

    % CPG  = Set of Co-paths Graphs in Set of Graphs
    % FC   = The number of each unique graph
    % FCC  = Frequency Count (how many graphs were seen 1 time, 2 times, etc.)
    % FFV  = Frequency Count Values (the 1 time, 2 time part)
    % GS   = Graph Set (the actual set of graphs)
    % NCPG = Number of co-paths graphs within the set
    % UG   = Each Unique Graph as a graph6 encoded string
    % NA   = Number of automorhpisms each graph has
    % NAB  = Bins in the histogram of the number of automorphisms
    % NAC  = Counts in the histogram of the number of automorphisms
    % REG  = Number of regular graphs in the graph set.
    % ANA  = Average Number of Automorphisms
    
    dataPath = ['alternative generator/data p=',num2str(P),'/',ALG,'/CANNON_',ALG,'-',SIZE];

    load(dataPath);

    GSname = ['GS_',ALG,SIZE];
    if ~exist(GSname, 'var')
        eval([GSname,' = graphSet;']);
        save(dataPath, 'graphSet', GSname);
    end

    UGname = ['UG_',ALG,SIZE]; 
    FCname = ['FC_',ALG,SIZE];
    FFVname = ['FFV_',ALG,SIZE]; 
    FFCname = ['FFC_',ALG,SIZE];
    if ~exist(UGname, 'var')
        eval(['[',UGname,', ',FCname,', ',FFVname,', ',FFCname,'] = getHistogramCountsInCannonicalSet(graphSet);']);
    end


    CPGname = ['CPG_',ALG,SIZE];
    NCPGname = ['NCPG_',ALG,SIZE];
    if ~exist(NCPGname, 'var')
        eval(['[', NCPGname,',',CPGname,'] = findNumberOfCoPathsGraphsInCannonicalSet(graphSet);']);
    end


    NAname = ['NA_',ALG,SIZE];
    NACname = ['NAC_',ALG,SIZE];
    NABname = ['NAB_',ALG,SIZE];
    if ~exist(NAname, 'var')
        eval(['[', NAname,',',NACname,',',NABname,'] = findAutomorphismsDistributionInCannonicalSet( graphSet );']);
    end


    REGname = ['REG_',ALG,SIZE];
    if ~exist(REGname, 'var')
        eval([REGname,' = countNumberOfRegularGraphs( graphSet );']);
    end
    
    
    ANAname = ['ANA_',ALG,SIZE];
    if ~exist(ANAname, 'var')
        eval([ANAname,' = dot(',NABname,', ',NACname,') / numel(',NAname,');']);
    end
    
    save(dataPath, 'graphSet', GSname, UGname, FCname, FFVname, FFCname, CPGname, NCPGname, NAname, NACname, NABname, REGname, ANAname, 'P', 'ALG', 'SIZE');
end