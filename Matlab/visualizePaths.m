function [ output_args ] = visualizePaths( graphs_name )

 graphs = evalin('base', graphs_name);
    for i = 1 : size(graphs)
        A = graph6(graphs(i,:));
        
        figure;
        %ax1 = subplot(1,2,1);
        %gplot(ax1, A);

        %ax2 = subplot(1,2,2);
        ax2 = subplot(1,1,1);
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

        set(gca,'XTick',1:v-1,'XTickLabel',2:v, ...
                'YTick',1:v, 'YTickLabel',labels, 'TickLength',[0 0]);
        
        
        
        
        path = strcat('visualization/',graphs_name,'-',char(64+i),'-paths.png');
        print(path,'-dpng');
        close all;
    end 

end

