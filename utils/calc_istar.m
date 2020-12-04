% Find istar given the EMD components and the real trend by using the 
% Euclidean distance.
%
% INPUTS:
% comps: EMD components including the imfs and the residual
% trend: original trend of the time series
%
% OUTPUTS:
% istar: best index to make estimate the trend using the EMD components


function istar = calc_istar(comps, trend)
    assert(size(comps, 2) == size(trend, 2), strcat("Time series and trend have to be of same size. |Time series|=", num2str(size(comps, 2))," vs |Trend|=", num2str(size(trend, 2))));
    n_comps = size(comps, 1);
    best_trend = zeros(1, 2);
    for i=1:n_comps
        candidate_trend = sum(comps(i:end, :),1);
        candidate_ed = norm(candidate_trend-trend);
        if i==1
            best_trend = [i, candidate_ed];
        elseif candidate_ed < best_trend(2)
            best_trend = [i, candidate_ed];
        end
    end
    istar = best_trend(1);
    if istar == size(comps, 1)
        istar = [];
    end
end