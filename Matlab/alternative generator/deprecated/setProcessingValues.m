function setProcessingValues( P, ALG, SIZE )

    dataPath = ['alternative generator/data p=',num2str(P),'/',ALG,'/CANNON_',ALG,'-',SIZE];
    
    load(dataPath);
    
    save(dataPath, 'graphSet', 'P', 'ALG', 'SIZE');

end

