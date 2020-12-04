% Make a random cubic splines trend
%
% INPUTS:
% N: length of time series
% P: how many segments the trends has
% range: range of the values in the trend
%
% OUTPUTS:
% trend: minimum and maximum values for the optimal p
% points: x and y points made and used to make the splines


function [trend, points] = maketrend_cubic(N, P, range)
    assert(length(range)==2);

    points = zeros(2,P+1);
    points(1, 1) = 1;
    points(1, end) = N;
    i = 2;
    
    while i<N
        points(1, i) = fix(rand .* N);
        dispoints(points(1,1:i));
        dispoints(unique(points(1,1:i)));
        if length(points(1,1:i)) == length(unique(points(1, 1:i)))
            i = i+1;
        end
    end
    points(1,:) = sort(points(1,:));
    
    mult = (range(2) - range(1));
    midp = (range(2) + range(1)) / 2;
    
    for i=1:length(points)
        points(2, i) = ((rand-0.5) .* mult) + midp;
    end
    
    trend = spline(points(1,:), points(2,:), 1:N);
end