function saveScoreAgainstBaseline(alg, n, p, metric, marginalScore)

    p = floor (p * 100);
    baseName = [metric,'_',num2str(n), '_', num2str(p),'_',alg, '_SCORE'];
    
    eval([baseName, ' = marginalScore;']);
    
    save('alternative generator/data/scoresAgainstBaseline', baseName, '-append');

end

