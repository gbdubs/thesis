function visualizeGraphPaths( A , name , recurse )
    if ~exist('recurse','var') || isempty(recurse)
        recurse = false;
    end

    fig = figure('position', [0,0, 1200, 1000]);
    fig.PaperUnits = 'inches';
    fig.PaperPosition = [0 0 12 10];
    fig.PaperPositionMode = 'manual';
    
    v = size(A, 1);
    
    % Finds and displays the paths equivalency classes for the graph.
    equivClasses = findQuaziEquivalenceClasses(A);
    ax = axes('position',[0,0,1,1],'visible','off');
    subplot(2,2,3,ax);
    tx = text(0,1,'Paths Equivalence Classes');
    set(tx, 'FontSize', 25);
    for i = 1 : size(equivClasses, 2)
        txt = text(0,(v-i)/v, mat2str(cell2mat(equivClasses(1, i))));
        set(txt, 'FontSize', 20);
    end
    
    % Finds and displays the true equivalency classes for the graph.
    equivClasses = deduceAutomorphismGroupsFromAutomorphisms(findAllAutomorphisms(A));
    ax = axes('position',[0,0,1,1],'visible','off');
    subplot(2,2,4,ax);
    tx = text(0,1,'True Equivalence Classes');
    set(tx, 'FontSize', 25);
    for i = 1 : size(equivClasses, 2)
        txt = text(0,(v-i)/v, mat2str(cell2mat(equivClasses(1, i))));
        set(txt, 'FontSize', 20);
    end
    
    ax1 = subplot(2,2,1);
    g = graph(A);
    plot(ax1, g);
    % Overal title, at the top of the file.
    txt = text(ax1.XLim(2)+.4,ax1.YLim(2)+.4,name);
    set(txt,'fontweight','bold','FontSize', 40,'HorizontalAlignment', 'center');

    ax2 = subplot(2,2,2);
    colormap(ax2, hsv);

    sizes = size(A);
    v = sizes(1);

    temp = generateLabeledKs(A, v);
    labels = strcat(num2str(temp(:,v+1)), '-', char(64 + temp(:,v+1)));
    actual = zeros(v, v-1, 'double');
    actual(:,1:v-1) = log(cast(temp(:,2:v),'double') + 1);
    actual = actual - repmat(mean(actual), v, 1);

    imagesc(actual);
    colormap(flipud(gray));

    textStrings = num2str(actual(:),'%0.2f');        
    textStrings = strtrim(cellstr(textStrings));    
    [x,y] = meshgrid(1:v-1, 1:v);                   

    hStrings = text(x(:),y(:),textStrings(:), 'HorizontalAlignment','center');

    textColors = repmat(actual(:) > 0, 1, 3); 

    set(hStrings,{'Color'},num2cell(textColors,2)); 

    set(gca,'XTick',1:v-1,'XTickLabel',2:v, 'YTick',1:v, 'YTickLabel',labels, 'TickLength',[0 0]);

    path = strcat('visualization/regular/',name,'.png');
    print(path,'-dpng');
    
    for i = 1 : size(A, 1)
        idx = setdiff(1:v, i);
        tempGraph = A(idx, idx);
        score = scoreEquivalencyClasses(findQuaziEquivalenceClasses(tempGraph));
        if (score > 70 && recurse)
            visualizeGraphPaths( tempGraph , [name, '-',num2str(i)] , false );
        end
    end
    
    close all;
end

