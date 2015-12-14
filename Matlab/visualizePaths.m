function [ output_args ] = visualizePaths( A )
sizes = size(A);
v = sizes(1);

temp = generateLabeledKs(A, v);
actual = zeros(v, v+1, 'double');
actual(:,1:v) = log(cast(temp(:,1:v),'double') + 1);
actual = actual - repmat(mean(actual), v, 1);

imagesc(actual);                                   %# Create a colored plot of the matrix values
colormap(flipud(gray));                         %# Change the colormap to gray (so higher values are
                                                %#   black and lower values are white)

textStrings = num2str(actual(:),'%0.2f');          %# Create strings from the matrix values
textStrings = strtrim(cellstr(textStrings));    %# Remove any space padding
[x,y] = meshgrid(1:v+1);                        %# Create x and y coordinates for the strings

hStrings = text(x(:),y(:),textStrings(:), 'HorizontalAlignment','center');

midValue = mean(get(gca,'CLim'));               %# Get the middle value of the color range
textColors = repmat(mat(:) > midValue,1,3);     %# Choose white or black for the
                                                %#   text color of the strings so
                                                %#   they can be easily seen over
                                                %#   the background color
set(hStrings,{'Color'},num2cell(textColors,2)); %# Change the text colors



set(gca,'XTick',1:v,...                         %# Change the axes tick marks
        'XTickLabel',1:v,...  %#   and tick labels
        'YTick',char(65:65+v),...
        'YTickLabel',1:v,...
        'TickLength',[0 0]);

end

