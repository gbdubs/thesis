function [fitresult] = fitToExponentialOfNumberOfEdges(X1, Y1)

[xData, yData] = prepareCurveData( X1, Y1 );

ft = fittype( 'a*exp(-b*sqrt(x*(x-1)))+c', 'independent', 'x', 'dependent', 'y' );
opts = fitoptions( 'Method', 'NonlinearLeastSquares' );
opts.Display = 'Off';
opts.StartPoint = [0.0156370891283055 0.602754561541912 0.863100709726974];

[fitresult, ~] = fit( xData, yData, ft, opts );

end

