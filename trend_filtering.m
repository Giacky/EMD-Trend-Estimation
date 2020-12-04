% Full application of the trend estimation method for any of the four
% approaches desired
%
% INPUTS:
% s: the time series whose trend is to be found
% approach: approach id that is wanted to be used. (1: ratio, 2: energy,
% 3:energy-ratio, 4:linear regressions)
% threshs: array containing the two thresholds that want to be used in the
%          case that either the ratio or energy-ratio approach are utilised.
%
% OUTPUTS:
% trend: the estimated trend of the time series
% 
% If no output variables are given a figure showing the original signal,
% the EMD components and the final estimated trend is shown

function trend = trend_filtering(s, approach, threshs)
    imfs = emd(s);
    res = imfs(end,:);
    imfs(end,:) = [];
    
    if nargin <= 2
        threshL = OPTIONS().threshL;
        threshR = OPTIONS().threshR;
    else
        threshL = threshs(1);
        threshR = threshs(2);
    end
    
    Zs = count_Zs(imfs);
    istar = [];
    switch approach
        case 1
            istars = ratio_approach(Zs, [threshL, threshR]);
            if ~isempty(istars)
                istar = istars(1);
            end
        case 2
            istars = energy_approach(imfs);
            if ~isempty(istars)
                istar = istars(1);
            end
        case 3
            istar = energyratio_approach(imfs, Zs, [threshL, threshR]);
        otherwise
            istar = lineartrends_approach(imfs, res);
    end
    
    trend = zeros(1, size(imfs, 2));
    for i = istar:size(imfs, 1)
        trend = trend + imfs(i, :);
    end
    trend = trend + res;
    
    
    t_plot = 1:length(trend);
    imf_count = size(imfs, 1);
    
    
    % Scrollable figure the original signal, EMD components and estimated
    % trend
    if nargout ==  0
        numPlots = imf_count + 3;
        pixelHeightPerPlot = 200;
        f = uifigure('Name', 'Original Signal, IMFs + Residual, and Trend');
        f.Scrollable = true;
        p = uipanel(f, 'Position',[0 0 f.Position(3)-25 numPlots*pixelHeightPerPlot]);
        p.BorderType = 'none';
        t = tiledlayout(p, numPlots, 1);
        t.Padding = 'none';

        ax = nexttile(t);
        plot(ax, t_plot, s);
        title(ax, 'Original Signal');

        for i = 1:imf_count
            ax = nexttile(t);
            plot(ax, t_plot, imfs(i,:));
            if i >= istar
                color_font = 'red';
            else
                color_font = 'blue';
            end
            title(ax, ['IMF ' num2str(i)], 'Color', color_font);
        end

        ax = nexttile(t);
        plot(ax, t_plot, res);
        title(ax, 'Residual', 'Color', 'red');

        ax = nexttile(t);
        plot(ax, t_plot, s);
        hold(ax);
        plot(ax, t_plot, trend);
        title(ax, 'Original Signal and Trend');
    end
    
end
