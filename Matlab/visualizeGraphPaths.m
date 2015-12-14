function visualizeGraphPaths( A , name)
    fig = figure('position', [0,0, 1200, 500]);
    fig.PaperUnits = 'inches';
    fig.PaperPosition = [0 0 10 4];
    fig.PaperPositionMode = 'manual';
    
    ax1 = subplot(1,2,1);
    g = graph(A);
    plot(ax1, g);

    ax2 = subplot(1,2,2);
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

    path = strcat('visualization/',name,'.png');
    print(path,'-dpng');
    close all;
end

