function [ADSM, DSMV, ADSMD, DSMDV, ADSMN, DSMNV, ADSMX, DSMXV, ADSV, DSVV] = ADSM_DSMV_ADSMD_DSMDV_ADSMN_DSMNV_ADSMX_DSMXV_ADSV_DSVV( graphSet )
    
    % MEAN
    % ADSM  = Average Degree Sequence Mean
    % DSMV  = Degree Sequence Mean Variance

    % MEDIAN
    % ADSMD = Average Degree Sequence Median
    % DSMDV = Degree Sequence Median Variance
    
    % MIN
    % ADSMN = Average Degree Sequence Minimum
    % DSMNV = Degree Sequence Minimum Variance
    
    % MAX
    % ADSMX = Average Degree Sequence Minimum
    % DSMXV = Degree Sequence Maximum Variance
    
    % VARIANCE
    % ADSV = Average Degree Sequence Variance
    % DSVV = Degree Sequence Variance Variance
    
    nGraphs = size(graphSet, 1);
    
    data = zeros(nGraphs, 5);
    
    for i = 1 : nGraphs
        A = graph6(graphSet(i,:));
        DS = sum(A);
        data(i,:) = [mean(DS), median(DS), min(DS), max(DS), var(DS)];
    end
    
    ADSM = mean(data(:,1));
    DSMV = var(data(:,1));
    
    ADSMD = mean(data(:,2));
    DSMDV = var(data(:,2));
    
    ADSMN = mean(data(:,3));
    DSMNV = var(data(:,3));
    
    ADSMX = mean(data(:,4));
    DSMXV = var(data(:,4));
    
    ADSV = mean(data(:,5));
    DSVV = var(data(:,5));
end

