function [ score ] = retrieveScoreAgainstBaseline(alg, n, p, metric)

    p = floor (p * 100);
    baseName = [metric,'_',num2str(n), '_', num2str(p),'_',alg, '_SCORE'];

    try
        score = getfield(load('alternative generator/data/scoresAgainstBaseline', baseName), baseName);
    catch
        score = -10000;
    end
end

