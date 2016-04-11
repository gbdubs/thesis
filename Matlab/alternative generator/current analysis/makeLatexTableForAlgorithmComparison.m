function makeLatexTableForAlgorithmComparison( metric, algorithm )

    cMap = zeros(64, 3);
    for i = 1 : 32
        cMap(i,:) = [1, 1 - (32 - i) / 32, 1 - (32 - i) / 32];
    end
    for i = 33 : 64
        cMap(i,:) = [1 - (i-32) / 32, 1 -  (i-32) / 32, 1];
    end
%     figure;
%     surf(peaks);
%     colormap(cMap);
    close all;
    scores = zeros(10, 10);

    getColorValue(10);
    getColorValue(-10);
    getColorValue(0);
    getColorValue(4.3245);
    
    function [ hex ] = getHex(rgb)
        assert(nargin==1,'This function requires an RGB input.') 
        assert(isnumeric(rgb)==1,'Function input must be numeric.') 

        sizergb = size(rgb); 
        assert(sizergb(2)==3,'rgb value must have three components in the form [r g b].')
        assert(max(rgb(:))<=255& min(rgb(:))>=0,'rgb values must be on a scale of 0 to 1 or 0 to 255')

        % If no value in RGB exceeds unity, scale from 0 to 255: 
        if max(rgb(:))<=1
            rgb = round(rgb*255); 
        else
            rgb = round(rgb); 
        end

        % Convert (Thanks to Stephen Cobeldick for this clever, efficient solution):

        hex(:,1:6) = reshape(sprintf('%02X',rgb.'),6,[]).'; 
    end

    
    function [ hexcode ] = getColorValue(val)
        val = ceil(max((val + 10) * 64 / 20, 1));
        x = cMap(val,:);
        hexcode = getHex(x);
    end

    function [ c ] = colorCell(score)
        c = [' \cellcolor[HTML]{',getColorValue(score),'} ',num2str(score, '%.2f')];
    end
    
    function [ r ] = generateRow1 (metric, n, p, algorithm)
    
        [sN, sMean, sSd] = retrieveFromBaseline(n, p, 'Standard', metric);
        [iN, iMean, iSd] = retrieveFromBaseline(n, p, 'Ideal', metric);
        [aN, aMean, aSd] = retrieveFromBaseline(n, p, algorithm, metric);
        
        pool = sqrt(sSd ^ 2 / sN + iSd ^ 2 / iN + aSd ^ 2 / aN);
        
        score = innerScoreAgainstBaseline(iMean, iSd, iN, sMean, sSd, sN, aMean, aSd, aN);
        scores(n, (uint8(p*10))) = score;
        
        normalizedDiff = (iMean - aMean) / (iMean - sMean);
        
        r = [' & ', num2str(p),  ' & ', num2str(pool, '%.4f'), ' & ', num2str(iMean, '%.3f'), ' & ', num2str(sMean, '%.3f'), ' & ', num2str(aMean, '%.3f'), ' & ',num2str(score, '%.3f'), ' & ', num2str(normalizedDiff, '%.3f'),' \\']; 
        
    end



    function [ r ] = generateRow2 (n)
        
        r = ['  ', num2str(n)];
        t = 0;
        
        for pr = .1 : .1 : .9
            
            temp = scores(n, (uint8(pr*10)));
            t = t + temp;
            r = [r, ' & ', colorCell(temp)];
            
        end
        
        
        r = [r, ' & ', num2str(t / 9,'%.3f'),' \\'];
    end

%     disp('\documentclass[11pt,a4paper]{report}');
% 
%     disp('\usepackage{mathtools, amsmath, listings, graphicx, amssymb, nth, cite,multirow,longtable,hyperref}');
%     disp('\usepackage[utf8]{inputenc}');
%     disp('\usepackage[table]{xcolor}');
% 
%     disp('\begin{document}');
    disp('\begin{longtable}{ | c | c || c | c | c | c | c | c | }');
    disp('\hline');
    disp(['\multicolumn{8}{|c|}{ Score Report For ',metric,' on Algorithm ',algorithm,'} \\']);
    disp('\hline');
    disp(['N & P & Pooled SD &  Ideal &  Gilbert & ',algorithm,'  & Score & Norm Diff \\']);
    disp(' \hline');
    disp(' \hline');
    disp(' \endhead');
    
    for n = 4 : 10
         disp(['\multirow{9}{*}{',num2str(n),'}', generateRow1(metric, n, .1, algorithm)]);
         for p = .2 : .1 : .9
             disp(generateRow1(metric, n, p, algorithm));
         end
         disp(' \hline');
    end

    disp('\hline');
    disp('\end{longtable}');
    
    
    
    
    
    disp('\begin{longtable}{ | c || c | c | c | c | c | c | c | c | c || c |}');
    disp('\hline');
    disp(['\multicolumn{11}{|c|}{ Score Report For ',metric,' on Algorithm ',algorithm,'} \\']);
    disp('\hline');
    disp('\multicolumn{11}{|c|}{ P } \\');
    disp('\hline');
    disp('N & .1 & .2 & .3 & .4 & .5 & .6 & .7 & .8 & .9 & Mean\\');
    disp(' \hline');
    disp(' \hline');
    disp(' \endhead');
    for n = 4 : 10
        disp(generateRow2(n));
    end
    avgRow = 'Mean & ';
    for p = 1 : 9
        avgRow = [avgRow, colorCell(mean(scores(4:10, p))), ' & '];
    end
    disp(' \hline');
    disp(' \hline');
    disp([avgRow, colorCell(mean(mean(scores(4:10, 1:9))))]);
    disp('\end{longtable}');
%     disp('\end{document}');
end
