function generateComparisonAccrossP( n, metric , doLog)
    
    if nargin < 3
        doLog = 0;
    end
        
    [standardXs, standardYs] = collectDataAcrossPs(n, 'Standard', metric, 0);
    [idealXs, idealYs] = collectDataAcrossPs(n, 'Ideal', metric, 0);
    
    if doLog
        standardYs = log(standardYs);
        idealYs = log(idealYs);
    end
    
    figure1 = figure;

    % Create axes
    axes1 = axes('Parent',figure1);
    hold(axes1,'on');

    % Create multiple lines using matrix input to plot
    plot1 = plot(idealXs,idealYs,'LineStyle','none');
    set(plot1,'DisplayName','Ideal Random Generator',...
        'MarkerFaceColor',[0 0.447058826684952 0.74117648601532],...
        'Marker','pentagram');
    
    plot2 = plot(standardXs,standardYs,'LineStyle','none');
    set(plot2,'DisplayName','Standard Random Generator',...
        'MarkerFaceColor',[0.850980401039124 0.325490206480026 0.0980392172932625],...
        'Marker','o',...
        'Color',[0.850980401039124 0.325490206480026 0.0980392172932625]);

    % Create xlabel
    xlabel('Probability of Individual Edge Existence','FontSize',16);

    % Create ylabel
    yLab = ['Metric ', metric];
    if doLog
        yLab = ['Logarithm of ', yLab];
    end
    ylabel({yLab,''},...
        'FontSize',14);

    % Create title
    title([metric,' over sets of 10K RGGs with N=',num2str(n),' with varrying P and Generators'],...
        'FontSize',14);

    % Set Probability Limits to 0-1.
    xlim(axes1,[0 1]);
    box(axes1,'on');

    % Create legend
    legend1 = legend(axes1,'show');
    set(legend1,...
        'Position',[0.415936720678956 0.749598539215709 0.232776617954071 0.0517774343122102],...
        'FontSize',14);
    
end

